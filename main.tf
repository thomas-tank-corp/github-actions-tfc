#EXAMPLE code###

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "emea-se-playground-2019"
    workspaces {
      prefix = "tharris-gh-demo-"
    }
  }
}

provider "vault" {}
 data "vault_generic_secret" "gcp_auth" {
 path = "gcp/key/actions-servicekey"
}

provider "google" {
  project     = "tharris-vault-customer-pov"
  region      = "europe-west2"
  zone        = "europe-west2a"
  credentials = base64decode(data.vault_generic_secret.gcp_auth.data.private_key_data)
}


resource "google_compute_instance" "default" {
  name         = "github-actions-${var.environment_tag}"
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
