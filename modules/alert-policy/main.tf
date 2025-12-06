resource "google_monitoring_notification_channel" "email" {
  project      = var.project_id
  display_name = var.notification_email_display_name
  type         = "email"
  labels = {
    email_address = var.notification_email
  }
}

resource "google_monitoring_alert_policy" "this" {
  project      = var.project_id
  display_name = var.display_name
  combiner     = var.combiner

  conditions {
    display_name = "VM Interface Traffic > ${var.threshold_value} B/s"
    condition_threshold {
      filter          = "metric.type=\"agent.googleapis.com/interface/traffic\" AND resource.type=\"gce_instance\" AND resource.label.\"instance_name\"=\"${var.instance_name}\""
      duration        = "60s" # Retest window of 1 min
      comparison      = "COMPARISON_GT"
      threshold_value = var.threshold_value

      trigger {
        count = 1
      }

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  documentation {
    content   = var.documentation_content
    mime_type = "text/markdown"
  }

  notification_channels = [google_monitoring_notification_channel.email.id]
}