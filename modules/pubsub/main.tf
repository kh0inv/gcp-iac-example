resource "google_pubsub_topic" "this" {
  name = var.pubsub_topic_name
}

resource "google_pubsub_subscription" "this" {
  name  = var.pubsub_subscription_name
  topic = google_pubsub_topic.this.name

  ack_deadline_seconds = var.ack_deadline

  dynamic "push_config" {
    for_each = var.push_endpoint != "" ? [true] : []
    content {
      push_endpoint = var.push_endpoint
      oidc_token {
        service_account_email = var.push_auth_service_account_email
      }
    }
  }

  depends_on = [
    google_pubsub_topic.this,
  ]
}

data "google_project" "project" {}

resource "google_project_iam_member" "pubsub_token_creator" {
  count   = var.enable_push_authentication ? [true] : []
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
