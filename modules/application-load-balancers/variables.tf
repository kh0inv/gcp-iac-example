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

variable "ip_name" {
  description = ""
  type        = string
}

variable "health_check_name" {
  description = ""
  type        = string
}