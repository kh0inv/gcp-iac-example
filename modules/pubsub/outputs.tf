output "pubsub_topic_name" {
  description = "The name of the pubsub topic."
  value       = google_pubsub_topic.this.name
}

output "pubsub_topic_id" {
  description = "The ID of the pubsub topic."
  value       = google_pubsub_topic.this.id
}

output "pubsub_subscription_name" {
  description = "The name of the pubsub subscription."
  value       = google_pubsub_subscription.this.name
}

output "pubsub_subscription_id" {
  description = "The ID of the pubsub subscription."
  value       = google_pubsub_subscription.this.id
}
