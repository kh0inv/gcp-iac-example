locals {
  network_name                   = basename(var.network)
  create_internal_load_balancing = contains(["INTERNAL", "INTERNAL_MANAGED"], var.load_balancing_scheme)
  create_proxy                   = false
  create_url_map                 = false
}

resource "google_compute_forwarding_rule" "this" {
  name   = coalesce(var.forwarding_rule_name, "${var.load_balancer_name}-forwarding-rule")
  region = var.region

  ip_address            = google_compute_address.this.address
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  ports                 = [var.port]
  target                = local.create_proxy ? google_compute_region_target_http_proxy.this.id : null
  backend_service       = google_compute_region_backend_service.this.id
  network               = var.network
}

resource "google_compute_address" "this" {
  name         = coalesce(var.ip_name, "${var.load_balancer_name}-ip")
  address_type = local.create_internal_load_balancing ? "INTERNAL" : "EXTERNAL"
  ip_version   = var.ip_version
  region       = var.region
}

resource "google_compute_region_target_http_proxy" "this" {
  count   = local.create_proxy ? 1 : 0
  name    = coalesce(var.target_http_proxies_name, "${var.load_balancer_name}-regional-url-map")
  region  = var.region
  url_map = google_compute_region_url_map.this.id
}

resource "google_compute_region_url_map" "this" {
  count           = local.create_url_map ? 1 : 0
  name            = coalesce(var.url_map_name, "${var.load_balancer_name}-regional-url-map")
  region          = var.region
  default_service = google_compute_region_backend_service.this.id
}

resource "google_compute_region_backend_service" "this" {
  name                  = coalesce(var.backend_service_name, "${var.load_balancer_name}-regional-backend-service")
  region                = var.region
  protocol              = var.protocol
  load_balancing_scheme = var.load_balancing_scheme

  health_checks = [google_compute_region_health_check.this.id]

  backend {
    group           = var.backend_instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_health_check" "this" {
  name   = coalesce(var.health_check_name, "${var.load_balancer_name}-regional-health-check")
  region = var.region

  http_health_check {
    port = var.port
  }
}

resource "google_compute_firewall" "allow-health-check" {
  name        = format("%s-allow-health-check", local.network_name)
  description = "The ingress rule allows traffic from the Google Cloud health checking systems (130.211.0.0/22 and 35.191.0.0/16). This uses the target tag lb-health-check to identify the VMs"
  network     = local.network_name

  allow {
    protocol = lower(var.ip_protocol)
    ports    = [var.port]
  }

  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["lb-health-check"]
}
