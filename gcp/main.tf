provider "google" {
  credentials = file("credentials.json")
  project     = "educational-302601"
  region      = "us-east1"
  zone        = "us-east1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "ace_vpc_network-2"
}

