output "network" {
  description = " The URI of the VPC network."
  value       = google_compute_network.vpc_network.self_link
}

output "network_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.vpc_network.name
}

output "network_id" {
  description = "The identifier of the VPC network with format projects/{{project}}/global/networks/{{name}}."
  value       = google_compute_network.vpc_network.id
}
