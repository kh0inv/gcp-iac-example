locals {
  bucket_access_controls = {
    for item in var.role_entity_list : replace(item, ":", "-") => { role = split(":", item)[0], entity = split(":", item)[1] }
  }
}

output "bucket_access_controls" {
  value = local.bucket_access_controls
}

resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = false

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

resource "google_storage_bucket_access_control" "this" {
  for_each = var.use_access_control_lists ? {} : local.bucket_access_controls
  bucket   = google_storage_bucket.this.name
  role     = each.value.role
  entity   = each.value.entity

  depends_on = [google_storage_bucket.this]
}

resource "google_storage_bucket_acl" "this" {
  count  = var.use_access_control_lists && length(var.role_entity_list) > 0 ? 1 : 0
  bucket = google_storage_bucket.this.name

  role_entity = var.role_entity_list

  depends_on = [google_storage_bucket.this]
}
