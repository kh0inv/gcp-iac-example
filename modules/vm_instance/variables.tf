variable "vm_name" {
  description = "A unique name for the VM instance."
  type        = string
}

variable "machine_type" {
  description = "The machine type to create."
  type        = string
}

variable "region" {
  description = "The region that project is located."
  type        = string
}

variable "zone" {
  description = "The zone that the machine should be created in."
  type        = string
}

variable "tags" {
  description = "List of network tags for the VM instance. These tags are used for setting up firewall rules to & from the VM instance. Setting this is permanent. Changing it later will require the VM to be destroyed and re-created. Use empty array [] if you intend to not use any network tags for this VM instance."
  type        = optional(list(string))
  default     = []
}

variable "allow_stopping_for_update" {
  description = "Allows Terraform to stop the VM instance to update its properties."
  type        = bool
  default     = true
}

variable "boot_disk_size" {
  description = "The size of the boot disk in GigaBytes. Must be at least the size of the boot disk image."
  type        = number
  default     = 10
}

variable "boot_disk_type" {
  description = "The GCE disk type. May be set to \"pd-standard\", \"pd-balanced\" or \"pd-ssd\"."
  type        = string
  default     = "pd-standard"
}

variable "boot_disk_image" {
  description = "The source image to build the VM's boot disk from. Can be specified by the image's self-link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}. Run 'gcloud compute images list' to get a list of compatible public images. Can also use custom image paths instead."
  type        = string
}

variable "vpc_subnetwork" {
  description = " The name or self_link of the subnetwork to attach this interface to."
  type        = string
}

variable "external_ip" {
  description = "An existing external IP to be attached to the VM instance. VM will become publicly reachable if this is specified."
  type        = string
}

variable "metadata_startup_script" {
  description = "The startup script"
  type        = string
}