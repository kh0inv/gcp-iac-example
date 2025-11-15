resource "google_compute_network" "this" {
  name                            = var.network_name
  routing_mode                    = var.network_routing_mode
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "this" {
  name    = var.subnetwork_name
  network = google_compute_network.this.id
  region  = var.region

  depends_on = [google_compute_network.this]
}
