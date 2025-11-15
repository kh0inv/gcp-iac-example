output "network" {
  description = " The URI of the VPC network."
  value       = google_compute_network.this.self_link
}

output "network_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.this.name
}

output "network_id" {
  description = "The identifier of the VPC network with format projects/{{project}}/global/networks/{{name}}."
  value       = google_compute_network.this.id
}

output "subnetwork" {
  description = " The URI of the VPC subnetwork."
  value       = google_compute_subnetwork.this.self_link
}

output "subnetwork_name" {
  description = "The name of the VPC subnetwork."
  value       = google_compute_subnetwork.this.name
}

output "subnetwork_id" {
  description = "The identifier of the VPC subnetwork with format projects/{{project}}/global/networks/{{name}}."
  value       = google_compute_subnetwork.this.id
}
