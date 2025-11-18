resource "google_eventarc_trigger" "this" {
  name     = var.eventarc_trigger_name
  location = var.region

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.pubsub.topic.v1.messagePublished"
  }

  destination {
    dynamic "cloud_run_service_name" {
      for_each = var.cloud_run_service_name != "" ? [true] : []
      content {
        service = var.cloud_run_service_name
        region  = var.region
      }
    }
  }

  transport {
    pubsub {
      topic = var.pubsub_topic_name
    }
  }

  # service_account = var.eventarc_trigger_service_account
}
