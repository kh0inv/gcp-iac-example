output "load_balancer_ip" {
  description = "The IP address of the load balancer."
  value       = google_compute_address.this.address
}

output "forwarding_rule" {
  description = "The self-link of the forwarding rule."
  value       = google_compute_forwarding_rule.this.self_link
}

output "forwarding_rule_name" {
  description = "The name of the forwarding rule."
  value       = google_compute_forwarding_rule.this.name
}

output "backend_service" {
  description = "The self-link of the backend service."
  value       = var.create_regional_services ? "" : google_compute_backend_service.this[0].self_link
}

output "backend_service_name" {
  description = "The name of the backend service."
  value       = var.create_regional_services ? "" : google_compute_backend_service.this[0].name
}

output "region_backend_service" {
  description = "The self-link of the regional backend service."
  value       = var.create_regional_services ? google_compute_region_backend_service.this[0].self_link : ""
}

output "region_backend_service_name" {
  description = "The name of the regional backend service."
  value       = var.create_regional_services ? google_compute_region_backend_service.this[0].name : ""
}
