variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy Cloud Run service (e.g., us-central1)"
  type        = string
  default     = "europe-west6"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "private-vpc"
}

variable "pcws_password" {
  description = "Password for the pcws database user"
  type        = string
  sensitive   = true
}