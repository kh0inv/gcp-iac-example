resource "google_project_service" "cloud_run_admin_api" {
  service = "run.googleapis.com"
}

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

    dynamic "containers" {
      for_each = var.template_image != "" ? [true] : []
      content {
        image = var.template_image
      }
    }
  }

  dynamic "build_config" {
    for_each = var.build_source_location != "" ? [true] : []
    content {
      source_location          = var.build_source_location
      function_target          = var.service_name
      base_image               = "${var.region}-docker.pkg.dev/serverless-runtimes/google-22-full/runtimes/nodejs22"
      enable_automatic_updates = true
    }
  }

  depends_on = [
    google_project_service.cloud_run_admin_api
  ]
}

# resource "google_service_account" "invoker" {
#   account_id   = var.service_account_id
#   display_name = var.service_account_name
# }

# resource "google_cloud_run_v2_service_iam_binding" "invoker" {
#   location = var.region
#   name     = google_cloud_run_v2_service.this.name

#   role = "roles/run.invoker"
#   members = [
#     "serviceAccount:${google_service_account.invoker.email}"
#   ]

#   depends_on = [
#     google_cloud_run_v2_service.this,
#     google_service_account.invoker
#   ]
# }
