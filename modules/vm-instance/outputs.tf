output "self_link" {
  description = "The URI of the created resource."
  value       = google_compute_instance.this.self_link
}

output "id" {
  description = "An identifier for the resource with format projects/{{project}}/zones/{{zone}}/instances/{{name}}"
  value       = google_compute_instance.this.id
}

output "instance_id" {
  description = "The server-assigned unique identifier of this instance. Example: 4567719474035761998"
  value       = google_compute_instance.this.instance_id
}

output "instance_name" {
  description = "The generated name of the GCloud VM Instance. Example: myubuntu2010-vm-tfa2c4"
  value       = google_compute_instance.this.name
}

output "external_ip" {
  description = "The external IP address attached to the VM instance."
  value       = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}
