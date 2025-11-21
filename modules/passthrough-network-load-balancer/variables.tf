variable "load_balancer_name" {
  description = "A name prefix for the load balancer and its related resources."
  type        = string
}

variable "forwarding_rule_name" {
  description = "The name of the forwarding rule. If not provided, a name will be generated."
  type        = string
  default     = ""
}

variable "backend_service_name" {
  description = "The name of the backend service. If not provided, a name will be generated."
  type        = string
  default     = ""
}

variable "health_check_name" {
  description = "The name of the health check. If not provided, a name will be generated."
  type        = string
  default     = ""
}

variable "region" {
  description = "The region where the load balancer and its components will be created."
  type        = string
}

variable "network" {
  description = "The self_link of the network to attach this load balancer to."
  type        = string
}

variable "subnetwork" {
  description = "The self_link of the subnetwork to attach this load balancer to."
  type        = string
}

variable "load_balancing_scheme" {
  description = "Specifies the forwarding rule type. For regional internal passthrough Network Load Balancers, this field must be INTERNAL. For regional external passthrough Network Load Balancers, this field must be EXTERNAL."
  type        = string
  default     = "INTERNAL"
  validation {
    condition     = contains(["INTERNAL", "EXTERNAL"], var.load_balancing_scheme)
    error_message = "Possible values are: INTERNAL, EXTERNAL."
  }
}

variable "ip_name" {
  description = "The name of the ip address."
  type        = string
  default     = ""
}

variable "ip_version" {
  description = "The IP Version that will be used by this address. Valid options are IPV4 or IPV6."
  type        = string
  default     = "IPV4"
}

variable "ip_protocol" {
  description = "The IP protocol to which this rule applies. For regional internal passthrough Network Load Balancers, valid values are TCP, UDP, and L3_DEFAULT."
  type        = string
  default     = "TCP"
}

variable "all_ports" {
  description = "If true, all ports are forwarded. If false, only the ports specified in `ports` are forwarded."
  type        = bool
  default     = false
}

variable "ports" {
  description = "A list of ports to forward. This is ignored if `all_ports` is true."
  type        = list(string)
  default     = []
}

variable "allow_global_access" {
  description = "This flag is used for internal passthrough Network Load Balancers. If true, clients from any region can access the load balancer."
  type        = bool
  default     = false
}

variable "backend_instance_group" {
  description = "The instance group that will receive traffic from the forwarding rule."
  type        = string
}

variable "balancing_mode" {
  description = "Defines how to distribute traffic to backends. Possible values are: CONNECTION, UTILIZATION."
  type        = string
  default     = "CONNECTION"
  validation {
    condition     = contains(["CONNECTION", "UTILIZATION"], var.balancing_mode)
    error_message = "Possible values are: CONNECTION, UTILIZATION."
  }
}

variable "create_firewall_rules" {
  description = "If true, firewall rules for health checks and load balancer source ranges will be created."
  type        = bool
  default     = true
}

variable "health_check_source_ranges" {
  description = "Source IP ranges to allow for health checks."
  type        = list(string)
  default     = ["130.211.0.0/22", "35.191.0.0/16"]
}

variable "health_check_port" {
  description = "The port number for the health check."
  type        = string
  default     = "80"
}

variable "lb_source_ranges" {
  description = "Source IP ranges to allow for load balancer traffic to the backends."
  type        = list(string)
  default     = []
}

variable "backend_network_tags" {
  description = "A list of network tags to apply to the firewall rules."
  type        = list(string)
  default     = []
}
