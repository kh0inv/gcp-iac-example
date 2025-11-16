resource "google_compute_network" "this" {
  name                            = var.network_name
  routing_mode                    = var.network_routing_mode
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "this" {
  name          = var.subnetwork_name
  network       = google_compute_network.this.id
  region        = var.region
  ip_cidr_range = var.subnetwork_ip_cidr_range

  depends_on = [google_compute_network.this]
}

resource "google_compute_firewall" "allow_internal" {
  name    = format("%s-allow-internal", var.network_name)
  network = google_compute_network.this.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [var.subnetwork_ip_cidr_range]
}
