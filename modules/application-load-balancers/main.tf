locals {
  network_name = basename(var.network)
}

gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80

resource "google_compute_forwarding_rule" "this" {
  name                  = coalesce(var.forwarding_rule_name, "${var.load_balancer_name}-forwarding-rule")
  region                = var.region
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.default.id
  network               = google_compute_network.ilb_network.id
  subnetwork            = google_compute_subnetwork.ilb_subnet.id
  network_tier          = "PREMIUM"
}

resource "google_compute_firewall" "allow-health-check" {
  name        = format("%s-allow-health-check", local.network_name)
  description = "The ingress rule allows traffic from the Google Cloud health checking systems (130.211.0.0/22 and 35.191.0.0/16). This uses the target tag lb-health-check to identify the VMs"
  network     = local.network_name

  allow {
    protocol = "tcp"
    ports    = [80]
  }

  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["lb-health-check"]
}

resource "google_compute_address" "this" {
  name       = coalesce(var.ip_name, "${var.load_balancer_name}-ip")
  ip_version = "IPV4"
  region     = var.region
}

resource "google_compute_region_health_check" "this" {
  name   = coalesce(var.health_check_name, "${var.load_balancer_name}-region-health-check")
  region = var.region

  http_health_check {
    port = "80"
  }
}

resource "google_compute_region_backend_service" "this" {
  name                  = coalesce(var.backend_service_name, "${var.load_balancer_name}-http-backend-service")
  region                = var.region
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "INTERNAL_MANAGED"

  health_checks = [google_compute_region_health_check.this.id]

  backend {
    group           = var.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_url_map" "this" {
  name            = coalesce(var.regional_url_map_name, "${var.load_balancer_name}-regional-url-map")
  region          = var.region
  default_service = google_compute_region_backend_service.http_backend_service.id
}

resource "google_compute_region_target_http_proxy" "this" {
  name    = coalesce(var.target_http_proxies_name, "${var.load_balancer_name}-regional-url-map")
  region  = var.region
  url_map = google_compute_region_url_map.this.id
}

