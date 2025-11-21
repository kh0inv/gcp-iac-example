resource "google_compute_forwarding_rule" "this" {
  name                  = coalesce(var.forwarding_rule_name, "${var.name}-forwarding-rule")
  backend_service       = google_compute_region_backend_service.this.id
  region                = var.region
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  all_ports             = var.all_ports
  ports                 = var.all_ports ? null : var.ports
  allow_global_access   = var.allow_global_access
  network               = var.network
  subnetwork            = var.subnetwork
}

resource "google_compute_region_backend_service" "this" {
  name                  = coalesce(var.backend_service_name, "${var.name}-backend-service")
  region                = var.region
  protocol              = var.ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  health_checks         = [google_compute_region_health_check.this.id]

  backend {
    group          = var.backend_instance_group
    balancing_mode = var.balancing_mode
  }
}

resource "google_compute_region_health_check" "this" {
  name   = coalesce(var.health_check_name, "${var.name}-health-check")
  region = var.region

  http_health_check {
    port = var.health_check_port
  }
}

# allow all access from health check ranges
resource "google_compute_firewall" "allow_health_check" {
  count         = var.create_firewall_rules ? 1 : 0
  name          = "${var.name}-fw-allow-hc"
  direction     = "INGRESS"
  network       = var.network
  source_ranges = var.health_check_source_ranges

  allow {
    protocol = lower(var.ip_protocol)
    ports    = [var.health_check_port]
  }

  target_tags = var.backend_network_tags
}

# allow communication within the subnet
resource "google_compute_firewall" "allow_lb_to_backends" {
  count         = var.create_firewall_rules && length(var.lb_source_ranges) > 0 ? 1 : 0
  name          = "${var.name}-fw-allow-lb-to-backends"
  direction     = "INGRESS"
  network       = var.network
  source_ranges = var.lb_source_ranges

  allow {
    protocol = "tcp"
    ports    = var.all_ports ? [] : var.ports
  }
  allow {
    protocol = "udp"
    ports    = var.all_ports ? [] : var.ports
  }
  allow {
    protocol = "icmp"
  }

  target_tags = var.backend_network_tags
}
