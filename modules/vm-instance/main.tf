locals {
  external_ip     = coalesce(var.external_ip, google_compute_address.external_ip.0.address)
  google_iap_cidr = "35.235.240.0/20" # IAP netblock - https://cloud.google.com/iap/docs/using-tcp-forwarding

  network_name = basename(var.network)
  all_network_tags = distinct(concat(
    var.network_tags,
    var.allow_http ? ["http-server"] : [],
    var.allow_https ? ["https-server"] : [],
    var.allow_load_balancer_health_check ? ["lb-health-check"] : []
  ))
}

resource "google_compute_address" "external_ip" {
  count  = var.external_ip != "" ? 0 : 1
  name   = coalesce(var.external_ip_name, "${var.vm_name}-ip")
  region = var.region
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = local.all_network_tags

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
  }

  network_interface {
    network = var.network

    dynamic "access_config" {
      for_each = var.external_ip != "" ? [true] : []
      content {
        nat_ip = local.external_ip
      }
    }
  }

  allow_stopping_for_update = var.allow_stopping_for_update
  metadata_startup_script   = var.metadata_startup_script
}

# resource "google_compute_firewall" "login_to_vm" {
#   count         = var.allow_login ? 1 : 0
#   name          = "login-to-${var.vm_name}"
#   network       = google_compute_instance.vm_instance.network_interface.0.network
#   source_ranges = distinct(concat(var.allowed_cidrs, [local.google_iap_cidr]))

#   allow {
#     protocol = "tcp"
#     ports    = distinct(concat(var.allowed_ports, [22, 3389]))
#   }
# }

resource "google_compute_firewall" "allow_rdp" {
  count       = var.allow_rdp ? 1 : 0
  name        = format("%s-allow-rdp", local.network_name)
  description = "Allows RDP traffic on port 3389"
  network     = local.network_name

  allow {
    protocol = "tcp"
    ports    = [3389]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  count       = var.allow_http ? 1 : 0
  name        = format("%s-allow-http", local.network_name)
  description = "Allows incoming HTTP traffic on port 80"
  network     = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
  count       = var.allow_https ? 1 : 0
  name        = format("%s-allow-https", local.network_name)
  description = "Allows incoming HTTPS traffic on port 443"
  network     = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
