# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "cloudsql-proxy-sa" {
 account_id = "cloudsql-proxy-sa"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "cloudsql-proxy-sa" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudsql-proxy-sa.email}"
}

# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
# resource "google_service_account_iam_member" "cloudsql-proxy-sa" {
#   service_account_id = google_service_account.cloudsql-proxy-sa.id
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "serviceAccount:${var.project_id}.svc.id.goog[wordpress/cloud-sql-access]"
# }
