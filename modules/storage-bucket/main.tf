resource "google_storage_bucket" "this" {
  name                        = var.name
  location                    = var.location
  storage_class               = var.storage_class
  labels                      = var.labels
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]
    content {
      default_kms_key_name = var.encryption.default_kms_key_name
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }
}

locals {
  iam_bindings_by_role = {
    for role in distinct(var.iam_members[*].role) : role => [
      for member in var.iam_members : member.member if member.role == role
    ]
  }
}

resource "google_storage_bucket_iam_binding" "this" {
  for_each = var.uniform_bucket_level_access ? local.iam_bindings_by_role : {}
  bucket   = google_storage_bucket.this.name
  role     = each.key
  members  = each.value
}

locals {
  bucket_access_controls = {
    for item in var.role_entity_list : "${item.role}-${item.entity}" => item
  }
}

resource "google_storage_bucket_access_control" "this" {
  for_each = !var.uniform_bucket_level_access && !var.use_access_control_lists ? local.bucket_access_controls : {}
  bucket   = google_storage_bucket.this.name
  role     = each.value.role
  entity   = each.value.entity

  depends_on = [google_storage_bucket.this]
}

locals {
  role_entity_list_strings = [for item in var.role_entity_list : "${item.role}:${item.entity}"]
}

resource "google_storage_bucket_acl" "this" {
  count  = !var.uniform_bucket_level_access && var.use_access_control_lists && length(var.role_entity_list) > 0 ? 1 : 0
  bucket = google_storage_bucket.this.name

  role_entity = local.role_entity_list_strings

  depends_on = [google_storage_bucket.this]
}
