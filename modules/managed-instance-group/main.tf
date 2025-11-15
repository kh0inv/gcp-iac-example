resource "google_compute_region_instance_group_manager" "this" {
  name   = var.instance_group_name
  region = var.region

  version {
    instance_template = google_compute_instance_template.this.id
  }

  base_instance_name = var.base_instance_name
  target_size        = var.target_size
}

resource "google_compute_instance_template" "this" {
  name         = var.instance_template_name
  machine_type = var.machine_type
  tags         = var.network_tags

  disk {
    boot         = true
    source_image = var.source_image
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.allocate_external_ip ? [true] : []
      content {}
    }
  }
  metadata_startup_script = var.metadata_startup_script
}
