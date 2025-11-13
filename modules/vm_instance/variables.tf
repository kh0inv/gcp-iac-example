# variable "name_suffix" {
#   description = "An arbitrary suffix that will be added to the end of the resource name(s). For example: an environment name, a business-case name, a numeric id, etc."
#   type        = string
#   validation {
#     condition     = length(var.name_suffix) <= 7
#     error_message = "A max of 7 character(s) are allowed."
#   }
# }

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
  type        = list(string)
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

variable "network" {
  description = "The name or self_link of the network to attach this interface to."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = " The name or self_link of the subnetwork to attach this interface to."
  type        = string
  default     = ""
}

variable "external_ip" {
  description = "An existing external IP to be attached to the VM instance. VM will become publicly reachable if this is specified."
  type        = string
  default     = ""
}

variable "metadata_startup_script" {
  description = "The startup script"
  type        = string
  default     = ""
}

variable "external_ip_name" {
  description = "An arbitrary name to identify the External IP that will be generated & attached to the VM instance (if \"var.create_external_ip\" is set to \"true\"). Uses \"var.instance_name\" if nothing is specified here."
  type        = string
  default     = ""
}

variable "allow_rdp" {
  description = "Setting this to \"true\" also creates firewall rules which allow RDP access to the VM"
  type        = bool
  default     = false
}

variable "allow_login" {
  description = "Whether the \"OS Login\" feature will be allowed in the VM instance. Setting this to \"true\" also creates firewall rules which allow SSH / RDP access to the VM via IAP tunnelling. See https://cloud.google.com/iap/docs/using-tcp-forwarding"
  type        = bool
  default     = false
}

variable "allowed_cidrs" {
  description = "List of IP CIDRs to be allowed by the VM firewall rules for incoming traffic."
  type        = list(string)
  default     = []
}

variable "allowed_ports" {
  description = "List of ports to be opened by the VM firewall rules for incoming traffic."
  type        = list(string)
  default     = []
}
