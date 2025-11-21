output "forwarding_rule_id" {
  description = "The ID of the forwarding rule."
  value       = google_compute_forwarding_rule.this.id
}

output "forwarding_rule_ip_address" {
  description = "The IP address of the forwarding rule."
  value       = google_compute_forwarding_rule.this.ip_address
}

output "backend_service_id" {
  description = "The ID of the backend service."
  value       = google_compute_region_backend_service.this.id
}

output "backend_service_self_link" {
  description = "The URI of the backend service."
  value       = google_compute_region_backend_service.this.self_link
}

output "health_check_id" {
  description = "The ID of the health check."
  value       = google_compute_region_health_check.this.id
}
