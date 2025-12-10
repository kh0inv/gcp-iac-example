resource "google_sql_database_instance" "main" {
  name   = var.name
  region = var.location

  database_version = var.database_version
  root_password    = var.root_password

  dynamic "settings" {
    for_each = coalesce(var.settings, {})
    content {
      tier    = settings.values.tier
      edition = settings.values.edition
    }
  }
}
