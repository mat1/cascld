resource "google_sql_database_instance" "bid_db" {
  name             = "bid-db"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"

    backup_configuration {
      # Required for HA Setup
      binary_log_enabled = true
      enabled            = true
    }

    ip_configuration {
      ipv4_enabled = true
    }
  }

  root_password = var.root_password
}

resource "google_sql_database" "bidapp" {
  name     = "bidapp"
  instance = google_sql_database_instance.bid_db.name
}

resource "google_sql_user" "bidapp_user" {
  name     = "bidapp"
  instance = google_sql_database_instance.bid_db.name
  password = var.bidapp_password
}
