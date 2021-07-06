#EXAMPLE code.#

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = ""

    workspaces {
      prefix = "app-tomh-"
    }
  }
}


provider "google" {
  project     = "tharris-vault-customer-pov"
  region      = "europe-west2"
  zone        = "europe-west2-a"
}


resource "google_compute_instance" "default" {
  name         = "github-actions-${var.environment_tag}-${var.name}"
  machine_type = "f1-micro"

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
