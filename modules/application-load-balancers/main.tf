locals {
  network_name                   = basename(var.network)
  create_internal_load_balancing = contains(["INTERNAL", "INTERNAL_MANAGED"], var.load_balancing_scheme)
  create_proxy                   = true
  create_url_map                 = true
}

resource "google_compute_forwarding_rule" "this" {
  name   = coalesce(var.forwarding_rule_name, "${var.load_balancer_name}-forwarding-rule")
  region = var.create_regional_services ? var.region : ""

  ip_address            = google_compute_address.this.address
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  ports                 = [var.port]
  target                = local.create_proxy ? (var.create_regional_services ? google_compute_region_target_http_proxy.this[0].id : google_compute_target_http_proxy.this[0].id) : ""
  backend_service       = local.create_proxy ? "" : (var.create_regional_services ? google_compute_region_backend_service.this[0].id : google_compute_backend_service.this[0].id)
  network               = var.network
  subnetwork            = var.subnetwork

  depends_on = [
    google_compute_address.this,
    google_compute_target_http_proxy.this,
    google_compute_backend_service.this,
    google_compute_region_target_http_proxy.this,
    google_compute_region_backend_service.this
  ]
}

resource "google_compute_address" "this" {
  name         = coalesce(var.ip_name, "${var.load_balancer_name}-ip")
  address_type = local.create_internal_load_balancing ? "INTERNAL" : "EXTERNAL"
  ip_version   = var.ip_version
  region       = var.region
  network      = local.create_internal_load_balancing ? var.network : ""
  subnetwork   = local.create_internal_load_balancing ? var.subnetwork : ""
}

resource "google_compute_target_http_proxy" "this" {
  count   = local.create_proxy && !var.create_regional_services ? 1 : 0
  name    = coalesce(var.target_http_proxies_name, "${var.load_balancer_name}-target-http-proxy")
  url_map = google_compute_url_map.this[0].id

  depends_on = [google_compute_url_map.this]
}

resource "google_compute_region_target_http_proxy" "this" {
  count   = local.create_proxy && var.create_regional_services ? 1 : 0
  name    = coalesce(var.target_http_proxies_name, "${var.load_balancer_name}-regional-target-http-proxy")
  region  = var.region
  url_map = google_compute_region_url_map.this[0].id

  depends_on = [google_compute_region_url_map.this]
}

resource "google_compute_url_map" "this" {
  count           = local.create_url_map && !var.create_regional_services ? 1 : 0
  name            = coalesce(var.url_map_name, "${var.load_balancer_name}-url-map")
  default_service = google_compute_backend_service.this[0].id

  depends_on = [google_compute_backend_service.this]
}

resource "google_compute_region_url_map" "this" {
  count           = local.create_url_map && var.create_regional_services ? 1 : 0
  name            = coalesce(var.url_map_name, "${var.load_balancer_name}-regional-url-map")
  region          = var.region
  default_service = google_compute_region_backend_service.this[0].id

  depends_on = [google_compute_region_backend_service.this]
}

resource "google_compute_backend_service" "this" {
  count                 = var.create_regional_services ? 0 : 1
  name                  = coalesce(var.backend_service_name, "${var.load_balancer_name}-backend-service")
  protocol              = var.protocol
  load_balancing_scheme = var.load_balancing_scheme

  health_checks = [google_compute_health_check.this[0].id]

  backend {
    group          = var.backend_instance_group
    balancing_mode = local.create_internal_load_balancing ? "CONNECTION" : "UTILIZATION"
  }

  depends_on = [google_compute_health_check.this]
}

resource "google_compute_region_backend_service" "this" {
  count                 = var.create_regional_services ? 1 : 0
  name                  = coalesce(var.backend_service_name, "${var.load_balancer_name}-regional-backend-service")
  region                = var.region
  protocol              = var.protocol
  load_balancing_scheme = var.load_balancing_scheme

  health_checks = [google_compute_region_health_check.this[0].id]

  backend {
    group          = var.backend_instance_group
    balancing_mode = local.create_internal_load_balancing ? "CONNECTION" : "UTILIZATION"
  }

  depends_on = [google_compute_region_health_check.this]
}

resource "google_compute_health_check" "this" {
  count = var.create_regional_services ? 0 : 1
  name  = coalesce(var.health_check_name, "${var.load_balancer_name}-health-check")

  http_health_check {
    request_path = var.health_check_path
    port         = var.port
  }
}

resource "google_compute_region_health_check" "this" {
  count  = var.create_regional_services ? 1 : 0
  name   = coalesce(var.health_check_name, "${var.load_balancer_name}-regional-health-check")
  region = var.region

  http_health_check {
    request_path = var.health_check_path
    port         = var.port
  }
}

resource "google_compute_firewall" "allow-to-backend-instance" {
  name        = format("%s-allow-to-backend-instance", local.network_name)
  description = "The ingress rule allows traffic from the forwarding rule and health checks to communicate with instances in backend group."
  network     = var.network

  allow {
    protocol = lower(var.ip_protocol)
    ports    = [var.port]
  }

  direction     = "INGRESS"
  source_ranges = [google_compute_address.this.address]
  target_tags   = var.backend_network_tags
}

# resource "google_compute_firewall" "allow-health-check" {
#   name        = format("%s-allow-health-check", local.network_name)
#   description = "The ingress rule allows traffic from the Google Cloud health checking systems (130.211.0.0/22 and 35.191.0.0/16). This uses the target tag lb-health-check to identify the VMs"
#   network     = var.network

#   allow {
#     protocol = lower(var.ip_protocol)
#     ports    = [var.port]
#   }

#   direction     = "INGRESS"
#   source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
#   target_tags   = ["lb-health-check"]
# }
