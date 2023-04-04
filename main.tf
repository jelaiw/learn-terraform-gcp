terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_network" "foonet" {
  name = "foonet"
}

resource "google_compute_firewall" "foonet-allow-ssh" {
  name    = "foonet-allow-ssh"
  network = google_compute_network.foonet.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "foovm"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "kali-linux-2023-1-cloud-genericcloud-amd64"
    }
  }

  network_interface {
    network = google_compute_network.foonet.name
    access_config {
    }
  }
}
