resource "google_service_account" "gke-service" {
  account_id = "gke-service"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "gke-cluster" {
  name     = "gke-cluster"
  location = var.region
  project  = var.project_id

  networking_mode = "VPC_NATIVE"
  network         = google_compute_network.vpc-main.self_link
  subnetwork      = google_compute_subnetwork.vpc-private.self_link

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ip-range"
    services_secondary_range_name = "services-ip-range"
  }

  network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled  = true
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

}


resource "google_container_node_pool" "general" {
  name       = "general"
  location   = var.region
  cluster    = google_container_cluster.gke-cluster.name
  project    = var.project_id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    labels = {
      app = "wordpress"
    }


    tags         = ["website", "wordpress"]
    machine_type = "e2-medium"

    service_account = google_service_account.gke-service.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
