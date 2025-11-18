output "eventarc_trigger_name" {
  description = "The name of the eventarc trigger."
  value       = google_eventarc_trigger.this.name
}

output "eventarc_trigger_id" {
  description = "The identifier for the eventarc trigger with format projects/{{project}}/locations/{{location}}/triggers/{{name}}"
  value       = google_eventarc_trigger.this.id
}
