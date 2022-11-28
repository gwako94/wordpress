# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "vpc-main" {
  name                    = "vpc-main"
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1500
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "vpc-private" {
  name                     = "vpc-private"
  project                  = var.project_id
  ip_cidr_range            = "10.5.0.0/20"
  region                   = var.region
  network                  = google_compute_network.vpc-main.self_link
  private_ip_google_access = true


  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}