output "service_url" {
  description = "The URL of the cloud run service."
  value       = google_cloud_run_v2_service.this.uri
}

output "service_id" {
  description = "The ID of the cloud run service."
  value       = google_cloud_run_v2_service.this.id
}

output "service_name" {
  description = "The name of the cloud run service."
  value       = google_cloud_run_v2_service.this.name
}

output "invoker_service_account_email" {
  description = "The email of the service account."
  value       = google_service_account.invoker.email
}
