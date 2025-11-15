variable "load_balancer_name" {
  description = ""
  type        = string
}

variable "forwarding_rule_name" {
  description = ""
  type        = string
}

variable "region" {
  description = ""
  type        = string
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to."
  type        = string
}

variable "subnetwork" {
  description = ""
  type        = string
}

variable "protocol" {
  description = ""
  type        = string
}

variable "ip_protocol" {
  description = ""
  type        = string
}

variable "port" {
  description = ""
  type        = number
}

variable "ip_name" {
  description = ""
  type        = string
}

variable "target_http_proxies_name" {
  description = ""
  type        = string
}

variable "url_map_name" {
  description = ""
  type        = string
}

variable "backend_service_name" {
  description = ""
  type        = string
}

variable "backend_instance_group" {
  description = ""
  type        = string
}

variable "health_check_name" {
  description = ""
  type        = string
}
