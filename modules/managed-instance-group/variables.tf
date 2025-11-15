variable "instance_group_name" {
  description = "The name of the managed instance group. Must be 1-63 characters long and comply with RFC1035."
  type        = string
}

variable "region" {
  description = "The region where the managed instance group resides."
  type        = string
}

variable "base_instance_name" {
  description = "The base name to use for instances in this group. The value must be 1-58 characters long. Instances are named by appending a hyphen and a random four-character string to the base instance name."
  type        = string
}

variable "target_size" {
  description = "The target number of running instances for this managed instance group. This value should be zero or greater. The default value is 0."
  type        = number
  default     = 0
}

variable "instance_template_name" {
  description = "The name of the instance template. If you leave this blank, Terraform will auto-generate a unique name."
  type        = string
}

variable "machine_type" {
  description = "The machine type to create."
  type        = string
}

variable "network_tags" {
  description = "The list of network tags to apply to instances. Tags are used to identify valid sources or targets for network firewalls."
  type        = list(string)
  default     = []
}

variable "source_image" {
  description = "The source image to create this disk."
  type        = string
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to."
  type        = string
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork to attach this interface to."
  type        = string
  default     = ""
}

variable "metadata_startup_script" {
  description = "An instance startup script to be executed when the instance is booted."
  type        = string
  default     = ""
}

variable "allocate_external_ip" {
  description = ""
  type        = bool
  default     = true
}
