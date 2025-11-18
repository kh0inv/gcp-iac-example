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

variable "min_instance_count" {
  description = "The minimum number of instances for the service. Set to 0 for no minimum."
  type        = number
  default     = 0
}

variable "max_instance_count" {
  description = "The maximum number of instances for the service."
  type        = number
  default     = 1
}

variable "ingress" {
  description = "Provides the ingress settings for this Service. On output, returns the currently observed ingress settings, or INGRESS_TRAFFIC_UNSPECIFIED if no revision is active. Possible values are: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER."
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"
  validation {
    condition     = contains(["INGRESS_TRAFFIC_ALL", "INGRESS_TRAFFIC_INTERNAL_ONLY", "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"], var.ingress)
    error_message = "Possible values are: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER."
  }
}

variable "execution_environment" {
  description = "The sandbox environment to host this Revision. Possible values are: EXECUTION_ENVIRONMENT_GEN1, EXECUTION_ENVIRONMENT_GEN2"
  type        = string
  default     = "EXECUTION_ENVIRONMENT_GEN1"
  validation {
    condition     = contains(["EXECUTION_ENVIRONMENT_GEN1", "EXECUTION_ENVIRONMENT_GEN2"], var.execution_environment)
    error_message = "Possible values are: EXECUTION_ENVIRONMENT_GEN1, EXECUTION_ENVIRONMENT_GEN2."
  }
}
