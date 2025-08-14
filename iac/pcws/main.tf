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

resource "google_cloud_run_v2_service" "pcws" {
  name     = "pcws"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.pcws.email

    containers {
      image = "gcr.io/${var.project}/pcws:latest"

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "real"
      }
      env {
        name  = "PCWS_DATALOG_DIRECTORY"
        value = "/mnt/pcws-bucket"
      }
      env {
        name  = "USE_ACCOUNT_SERVICE_MOCK"
        value = "true"
      }
      env {
        name  = "PCWS_DATASOURCE_JDBC_URL"
        value = "jdbc:postgresql://${google_sql_database_instance.pcws-db.private_ip_address}:5432/pcws-db"
      }
      env {
        name  = "PCWS_DATASOURCE_USERNAME"
        value = "pcws"
      }
      env {
        name  = "PCWS_DATASOURCE_PASSWORD"
        value = var.pcws_password
      }

      volume_mounts {
        mount_path = "/mnt/pcws-bucket"
        name       = "pcws-bucket"
      }
    }

    vpc_access {
      network_interfaces {
        network    = var.vpc_name
        subnetwork = var.vpc_name
      }
    }

    volumes {
      name = "pcws-bucket"
      gcs {
        bucket    = google_storage_bucket.pcws_bucket.name
        read_only = false # Set to false to allow writing
      }
    }
  }
}

# Create a bucket
resource "google_storage_bucket" "pcws_bucket" {
  name     = "${var.project}-pcws-bucket"
  location = var.region
}

# Create service account and allow write access
resource "google_service_account" "pcws" {
  account_id   = "pcws-sa"
  display_name = "PCWS Service Account"
}

resource "google_storage_bucket_iam_member" "cloud_run_write" {
  bucket = google_storage_bucket.pcws_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.pcws.email}"
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
