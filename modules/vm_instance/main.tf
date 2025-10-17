locals {
  external_ip = var.external_ip != null ? var.external_ip : google_compute_address.external_ip.0.address
}

resource "google_compute_address" "external_ip" {
  count  = var.external_ip != null ? 0 : 1
  name   = replace(var.vm_name, "vm", "ip-vm")
  region = var.region
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
  }


  network_interface {
    subnetwork = var.vpc_subnetwork
    dynamic "access_config" {
      for_each = var.external_ip != null ? [1] : [0]
      content {
        nat_ip = local.external_ip
      }
    }
  }

  allow_stopping_for_update = var.allow_stopping_for_update

  metadata_startup_script = var.metadata_startup_script

  # service_account {
  #   # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  #   email  = google_service_account.default.email
  #   scopes = ["cloud-platform"]
  # }
}
