resource "google_cloud_run_v2_service" "this" {
  name                = var.service_name
  location            = var.location
  deletion_protection = var.deletion_protection
  ingress             = var.ingress

  scaling {
    min_instance_count = var.min_instance_count
    max_instance_count = var.max_instance_count
  }

  template {
    execution_environment = var.execution_environment
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}
