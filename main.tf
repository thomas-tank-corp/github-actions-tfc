#EXAMPLE code#

terraform {
  backend "remote" {
    hostname = "iacdev.wpp.cloud"
    organization = "WPP-Lab"

    workspaces {
      prefix = "app-tomh-"
    }
  }
}


provider "google" {
  project     = "Sandbox"
  region      = "europe-west2"
  zone        = "europe-west2a"
}


resource "google_compute_instance" "default" {
  name         = "github-actions-${var.environment_tag}-${var.name}"
  machine_type = "f1-micro"
  zone         = "europe-west2-a"

  tags = ["test", "git"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
