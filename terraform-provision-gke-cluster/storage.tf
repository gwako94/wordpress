resource "google_sql_database" "database" {

  name     = "wordpress"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}


resource "google_sql_database_instance" "instance" {

  name             = "my-database-instance42"
  database_version = "MYSQL_5_7"
  region           = var.region
  project          = var.project_id
  settings {

    tier = "db-f1-micro"
    ip_configuration {

      ipv4_enabled = true
      authorized_networks {

        name  = "public  network"
        value = "0.0.0.0/0"
      }
    }
  }
}
resource "google_sql_user" "users" {

  name     = var.wordpress_user_name
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
  password = var.wordpress_user_password
}
