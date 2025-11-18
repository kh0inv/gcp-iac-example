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
}

resource "google_pubsub_topic" "this" {
  name = var.pubsub_topic_name
}
