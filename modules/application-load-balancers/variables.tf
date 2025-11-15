variable "load_balancer_name" {
  description = ""
  type        = string
  default     = ""
}

variable "load_balancing_scheme" {
  description = "Specifies the forwarding rule type"
  type        = string
  default     = ""
  validation {
    condition     = contains(["EXTERNAL", "EXTERNAL_MANAGED", "INTERNAL", "INTERNAL_MANAGED"], var.load_balancing_scheme)
    error_message = "Possible values are: EXTERNAL, EXTERNAL_MANAGED, INTERNAL, INTERNAL_MANAGED"
  }
}

variable "forwarding_rule_name" {
  description = ""
  type        = string
  default     = ""
}

variable "region" {
  description = ""
  type        = string
  default     = ""
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to."
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = ""
  type        = string
  default     = ""
}

variable "protocol" {
  description = ""
  type        = string
  default     = ""
}

variable "ip_protocol" {
  description = ""
  type        = string
  default     = ""
}

variable "port" {
  description = ""
  type        = number
  default     = 0
}

variable "ip_name" {
  description = ""
  type        = string
  default     = ""
}

variable "ip_version" {
  description = ""
  type        = string
  default     = "IPV4"
}

variable "create_proxy" {
  description = ""
  type        = bool
  default     = false
}

variable "target_http_proxies_name" {
  description = ""
  type        = string
  default     = ""
}

variable "url_map_name" {
  description = ""
  type        = string
  default     = ""
}

variable "backend_service_name" {
  description = ""
  type        = string
  default     = ""
}

variable "backend_instance_group" {
  description = ""
  type        = string
  default     = ""
}

variable "health_check_name" {
  description = ""
  type        = string
  default     = ""
}
