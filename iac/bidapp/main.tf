terraform {
  required_version = ">= 1.0"
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

resource "google_cloud_run_v2_service" "bid_app" {
  name     = "bidapp"
  location = var.region
  project  = var.project

  template {
    service_account = google_service_account.bid_app_sa.email

    containers {
      image = "gcr.io/${var.project}/bid-app:latest"

      env {
        name  = "MYSQL_UNIX_SOCKET"
        value = "/cloudsql/${google_sql_database_instance.bid_db.connection_name}"
      }

      env {
        name  = "MYSQL_PASSWORD"
        value = var.bidapp_password
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.bid_db.connection_name]
      }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

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
resource "google_cloud_run_v2_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.bid_app.location
  project  = var.project
  name     = google_cloud_run_v2_service.bid_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value = google_cloud_run_v2_service.bid_app.uri
}
