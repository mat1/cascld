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

resource "google_cloud_run_v2_service" "pcws" {
  name     = "pcws"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "gcr.io/${var.project}/pcws:latest"

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "real"
      }
      env {
        name  = "USE_DATALOG_SERVICE_MOCK"
        value = "true"
      }
      env {
        name = "USE_ACCOUNT_SERVICE_MOCK"
        value = "true"
      }
      env {
        name  = "PCWS_DATASOURCE_JDBC_URL"
        value = "jdbc:postgresql://${google_sql_database_instance.pcws-db.private_ip_address}:5432/postgres"
      }
      env {
        name  = "PCWS_DATASOURCE_USERNAME"
        value = "pcws"
      }
      env {
        name  = "PCWS_DATASOURCE_PASSWORD"
        value = var.pcws_password
      }
    }
    vpc_access {
      network_interfaces {
        network    = var.vpc_name
        subnetwork = var.vpc_name
      }
    }
  }
}

# Allow unauthenticated access
resource "google_cloud_run_service_iam_member" "invoker" {
  project  = var.project
  location = var.region
  service  = google_cloud_run_v2_service.pcws.name
  role     = "roles/run.invoker"
  member   = "allUsers" # Allow public access
}

output "cloud_run_url" {
  value = google_cloud_run_v2_service.pcws.uri
}
