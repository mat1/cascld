variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy Cloud Run service (e.g., us-central1)"
  type        = string
  default     = "europe-west6"
}
