output "id" {
  description = "The ID of the uptime check config."
  value       = google_monitoring_uptime_check_config.http.id
}

output "uptime_check_id" {
  description = "The id of the uptime check."
  value       = google_monitoring_uptime_check_config.http.uptime_check_id
}

output "name" {
  description = "The full name of the uptime check configuration."
  value       = google_monitoring_uptime_check_config.http.name
}
