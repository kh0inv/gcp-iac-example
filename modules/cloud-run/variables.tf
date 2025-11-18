variable "service_name" {
  description = "The name of the cloud run service."
  type        = string
  default     = ""
}

variable "location" {
  description = "The location of the cloud run service. It is also gcp region."
  type        = string
  default     = ""
}

variable "deletion_protection" {
  description = "When the field is set to false, deleting the service is allowed."
  type        = bool
  default     = false
}