
# Cloud run job to transfer logs
resource "google_cloud_run_v2_job" "transfer_logs_job" {
  name     = "transfer-logs-job"
  location = var.region

  template {
    task_count = 1
    template {
      service_account = google_service_account.pcws.email

      containers {
        image = "gcr.io/${var.project}/transfer-logs:latest"

        env {
          name  = "PCWS_DATALOG_DIRECTORY"
          value = "/mnt/pcws-bucket"
        }

        volume_mounts {
          mount_path = "/mnt/pcws-bucket"
          name       = "pcws-bucket"
        }
      }

      volumes {
        name = "pcws-bucket"
        gcs {
          bucket    = google_storage_bucket.pcws_bucket.name
          read_only = false
        }
      }
    }
  }
}

# Trigger Job Every Hour
resource "google_cloud_scheduler_job" "trigger_transfer_logs_job" {
  name        = "trigger-transfer-logs-job"
  description = "Trigger Cloud Run Job every hour"
  schedule    = "0 * * * *"
  time_zone   = "UTC"

  http_target {
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project}/jobs/${google_cloud_run_v2_job.transfer_logs_job.name}:run"
    http_method = "POST"

    oidc_token {
      service_account_email = google_service_account.pcws.email
    }

    headers = {
      "Content-Type" = "application/json"
    }
  }
}

# Permissions to Trigger Job
resource "google_cloud_run_v2_job_iam_member" "pcws_run_job_invoker" {
  name     = google_cloud_run_v2_job.transfer_logs_job.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.pcws.email}"
}
