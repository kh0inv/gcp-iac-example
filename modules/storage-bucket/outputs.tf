output "bucket" {
  description = "The URI of the created resource."
  value       = google_storage_bucket.this.self_link
}

output "bucket_name" {
  description = "Outputs the finally constructed bucket name. Will be necessary for external resources (eg: ServiceAccounts) to be granted permissions to read/write to."
  value       = google_storage_bucket.this.name
}

output "id" {
  description = "The identifier of the storage bucket with format projects/{{project}}/buckets/{{name}}."
  value       = google_storage_bucket.this.id
}

output "url" {
  description = "The base URL of the bucket, in the format gs://<bucket-name>."
  value       = google_storage_bucket.this.url
}
