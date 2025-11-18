resource "google_cloud_run_v2_service" "this" {
  name                = var.service_name
  location            = var.region
  deletion_protection = var.deletion_protection
  ingress             = var.ingress

  scaling {
    min_instance_count = var.min_instance_count
    max_instance_count = var.max_instance_count
  }

  template {
    execution_environment = var.execution_environment
    containers {
      image = var.template_container_image
    }
  }
}

resource "google_eventarc_trigger" "this" {
  name     = var.eventarc_trigger_name
  location = var.region

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.pubsub.topic.v1.messagePublished"
  }

  destination {
    cloud_run_service {
      service = google_cloud_run_v2_service.this.name
      region  = var.region
    }
  }

  transport {
    pubsub {
      topic = google_pubsub_topic.this.id
    }
  }

  # service_account = var.eventarc_trigger_service_account

  depends_on = [
    google_cloud_run_v2_service.this,
    google_pubsub_topic.this
  ]
}

resource "google_pubsub_topic" "this" {
  name = var.pubsub_topic_name
}

resource "google_service_account" "eventarc_sa" {
  account_id   = "eventarc-sa"
  display_name = "Eventarc Service Account"
}

resource "google_project_iam_member" "eventarc_sa_pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.eventarc_sa.email}"
}

resource "google_project_iam_member" "eventarc_sa_eventarc_admin" {
  project = var.project_id
  role    = "roles/eventarc.admin"
  member  = "serviceAccount:${google_service_account.eventarc_sa.email}"
}

resource "google_cloud_run_v2_service_iam_member" "cloudrun_invoker" {
  name     = google_cloud_run_v2_service.my_service.name
  location = google_cloud_run_v2_service.my_service.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.eventarc_sa.email}"
}

gcloud iam service-accounts create cloud-run-pubsub-invoker \
  --display-name "Cloud Run Pub/Sub Invoker"

gcloud run services add-iam-policy-binding pubsub-tutorial \
  --member=serviceAccount:cloud-run-pubsub-invoker@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/run.invoker


gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=serviceAccount:service-PROJECT_NUMBER@gcp-sa-pubsub.iam.gserviceaccount.com \
  --role=roles/iam.serviceAccountTokenCreator

gcloud pubsub subscriptions create myRunSubscription --topic myRunTopic \
  --ack-deadline=600 \
  --push-endpoint=SERVICE-URL/ \
  --push-auth-service-account=cloud-run-pubsub-invoker@PROJECT_ID.iam.gserviceaccount.com
