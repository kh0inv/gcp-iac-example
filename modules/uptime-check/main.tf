resource "google_monitoring_uptime_check_config" "http" {
  display_name = var.display_name
  timeout      = var.timeout
  period       = var.period

  http_check {
    port = var.port
  }

  monitored_resource {
    type = "gce_instance"
    labels = {
      project_id  = var.project_id
      instance_id = var.instance_name
      zone        = var.zone
    }
  }
}
