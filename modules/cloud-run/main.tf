resource "google_cloud_run_v2_service" "this" {
  name                = var.service_name
  location            = var.region
  deletion_protection = var.deletion_protection
  ingress             = var.ingress

  scaling {
    min_instance_count = var.min_instance_count
    max_instance_count = var.max_instance_count
  }

  template {
    execution_environment = var.execution_environment
    containers {
      image = var.template_container_image
    }
  }
}

resource "google_service_account" "invoker" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
}

resource "google_cloud_run_v2_service_iam_binding" "invoker" {
  location = var.region
  name     = google_cloud_run_v2_service.this.name

  role = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.invoker.email}"
  ]

  depends_on = [
    google_cloud_run_v2_service.this,
    google_service_account.invoker
  ]
}
