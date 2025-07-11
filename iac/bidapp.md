# Bid App mit Terraform

Architecture

## 0. Neues Projekt

Erstelle ein neues Google Cloud Projekt.

## 1. Push Image und Services aktivieren

Damit eine Anwendung über Google Cloud Run deployt werden kann, muss das Dockerimage in der Google Cloud Registry vorhanden sein.

1. Google Cloud Shell aktivieren
2. Docker Authentification konfigurieren

```sh
gcloud auth configure-docker
```

3. Dockerimage in die Cloud Registry pushen

```sh
# Aktiviere die Container Registry
gcloud services enable containerregistry.googleapis.com

# Hole das Image vom Dockerhub
docker pull ghcr.io/dsi-engineering-ag/kubernetes-hands-on-sampleapp:latest

docker tag ghcr.io/dsi-engineering-ag/kubernetes-hands-on-sampleapp:latest gcr.io/PROJECTID/bid-app

# Pushe das Image in die Google Container Registry
docker push gcr.io/PROJECTID/bid-app
```

Aktiviere weitere benötigte Services. Dieser Schritt wäre auch über Terraform möglich.

```sh
gcloud services enable run.googleapis.com cloudbuild.googleapis.com
```

## 2. Cloud Run

1. Erstelle einen Order bidapp.
2. Erstelle eine Datei `variables.tf` mit diesem Inhalt:

```terraform
variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy Cloud Run service (e.g., us-central1)"
  type        = string
  default     = "europe-west6"
}
```

3. Erstelle eine Datei `terraform.tfvars` mit diesem Inhalt:

```terraform
project = "cas-terraform-bidapp"
```

4. Erstelle die Datei `main.tf` mit diesem Inhalt:

```terraform
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
      containers {
        image = "gcr.io/${var.project}/bid-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
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
```

5. Führe diese Befehle durch:

```sh
terraform init
terraform apply
```

Anschliessend sollte die Bid App unter der URL erreichbar sein.

## 3. Database

## 4. Connect Cloud Run to Database

