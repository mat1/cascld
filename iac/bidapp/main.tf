terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_cloud_run_service" "default" {
  name     = "bidapp"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.bid_app_sa.email

      containers {
        image = "gcr.io/${var.project}/bid-app:latest"

        env {
          name  = "MYSQL_UNIX_SOCKET"
          value = "/cloudsql/${google_sql_database_instance.bid_db.connection_name}"
        }
        env {
          name  = "MYSQL_PASSWORD"
          # Use secret manager for real setups
          value = "password123" 
        }
      }
    }

    # Use cloud SQL auth proxy
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.bid_db.connection_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Service account for bid app (allows bid app to connect to DB)
resource "google_service_account" "bid_app_sa" {
  account_id   = "bid-app-sa"
  display_name = "Bid App Service Account"
}

resource "google_project_iam_member" "cloudsql_client_role" {
  role    = "roles/cloudsql.client"
  project = var.project
  member  = "serviceAccount:${google_service_account.bid_app_sa.email}"
}

# Allow unauthenticated access
resource "google_cloud_run_service_iam_member" "noauth" {
  location = google_cloud_run_service.default.location
  project  = var.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value = google_cloud_run_service.default.status[0].url
}
