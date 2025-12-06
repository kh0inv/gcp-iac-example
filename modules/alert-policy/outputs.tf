output "alert_policy_id" {
  description = "The ID of the alert policy."
  value       = google_monitoring_alert_policy.this.id
}

output "alert_policy_name" {
  description = "The server-generated name of the alert policy."
  value       = google_monitoring_alert_policy.this.name
}

output "notification_channel_id" {
  description = "The ID of the notification channel."
  value       = google_monitoring_notification_channel.email.id
}

output "notification_channel_name" {
  description = "The server-generated name of the notification channel."
  value       = google_monitoring_notification_channel.email.name
}
