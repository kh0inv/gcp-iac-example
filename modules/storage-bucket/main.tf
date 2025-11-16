resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = false

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

resource "google_storage_bucket_access_control" "this" {
  count  = var.uniform_bucket_level_access ? 1 : 0
  bucket = google_storage_bucket.this.name
  role   = var.bucket_access_role
  entity = var.bucket_access_entity

  depends_on = [google_storage_bucket.this]
}
