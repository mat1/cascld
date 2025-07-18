variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy Cloud Run service (e.g., us-central1)"
  type        = string
  default     = "europe-west6"
}

variable "root_password" {
  description = "Root password for the MySQL instance"
  type        = string
  sensitive   = true
}

variable "bidapp_password" {
  description = "Password for the bidapp database user"
  type        = string
  sensitive   = true
}