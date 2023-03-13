terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("service_account_key.json")
  project     = "learn-terraform-gcp-tutorial"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "foonet"
}