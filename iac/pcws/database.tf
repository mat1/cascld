# VPC to use private IP to connect cloud run to database

resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
}

resource "google_compute_global_address" "private_ip_addres" {
  name          = "sql-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_addres.name]
}

# Database

resource "google_sql_database_instance" "pcws-db" {
  name             = "pcws-db"
  database_version = "POSTGRES_16"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.vpc_network.id
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "pcws-db" {
  name     = "pcws-db"
  instance = google_sql_database_instance.pcws-db.name
}

resource "google_sql_user" "pcws" {
  name     = "pcws"
  instance = google_sql_database_instance.pcws-db.name
  password = var.pcws_password
}
