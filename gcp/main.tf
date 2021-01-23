provider "google" {
  credentials = file("credentials.json")
  project     = "educational-302601"
  region      = "us-east1"
  zone        = "us-east1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "ace-instance-1"
  machine_type = "g1-small"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  service_account {
    scopes = ["storage-ro", "logging-write", "monitoring-write", "pubsub", "service-management", "service-control"]
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "ace-vpc-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "vpc_firewall" {
  name    = "allow-all-ingress-firewall-rule"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
  }
}
