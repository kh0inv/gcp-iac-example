output "cloud_run_url" {
  description = "The URL of the cloud run service."
  value       = google_cloud_run_v2_service.this.uri
}

output "cloud_run_id" {
  description = "The ID of the cloud run service."
  value       = google_cloud_run_v2_service.this.id
}

output "cloud_run_name" {
  description = "The name of the cloud run service."
  value       = google_cloud_run_v2_service.this.name
}

output "invoker_service_account_email" {
  description = "The email of the service account."
  value       = google_service_account.invoker.email
}

output "invoker_service_account_key" {
  description = "The private key for the service account, base64 encoded."
  value       = google_service_account_key.invoker_key.private_key
  sensitive   = true
}
