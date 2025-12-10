resource "google_sql_database_instance" "this" {
  name   = var.name
  region = var.location

  database_version = var.database_version
  root_password    = var.root_password

  dynamic "settings" {
    for_each = var.settings != null ? [var.settings] : []
    content {
      tier    = settings.value.tier
      edition = settings.value.edition

      availability_type = settings.value.availability_type

      dynamic "location_preference" {
        for_each = settings.value.location_preference != null ? [settings.value.location_preference] : []
        content {
          zone           = location_preference.value.zone
          secondary_zone = location_preference.value.secondary_zone
        }
      }

      dynamic "data_cache_config" {
        for_each = settings.value.data_cache != null ? [settings.value.data_cache] : []
        content {
          data_cache_enabled = data_cache_config.value.data_cache_enabled
        }
      }

      disk_autoresize_limit = settings.value.disk_autoresize_limit
    }
  }
}
