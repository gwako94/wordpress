resource "google_storage_bucket" "wordpress-output-bucket" {
  name          = "wordpress-output-bucket"
  location      = "US"
  force_destroy = true
  project = var.project_id
}