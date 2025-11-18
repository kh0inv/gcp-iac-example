resource "google_cloud_run_v2_service" "default" {
  name                = var.service_name
  location            = var.location
  deletion_protection = var.deletion_protection
  ingress             = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 100
  }

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}
