terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.1"
    }
  }
}


# Google Cloud Platform Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_id
  region  = var.region
}



