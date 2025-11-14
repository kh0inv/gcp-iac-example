resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_network_name
  routing_mode                    = var.vpc_network_routing_mode
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = false
}
