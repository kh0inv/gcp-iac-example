variable "load_balancer_name" {
  description = "The name for the load balancer. This is used as a prefix for the names of the load balancer resources."
  type        = string
}

variable "load_balancing_scheme" {
  description = "Specifies the forwarding rule type. For regional internal passthrough Network Load Balancers, this field must be INTERNAL. For regional external passthrough Network Load Balancers, this field must be EXTERNAL. For regional internal Application Load Balancers, this field must be INTERNAL_MANAGED. For regional external Application Load Balancers, this field must be EXTERNAL_MANAGED."
  type        = string
  validation {
    condition     = contains(["EXTERNAL", "EXTERNAL_MANAGED", "INTERNAL", "INTERNAL_MANAGED"], var.load_balancing_scheme)
    error_message = "Possible values are: EXTERNAL, EXTERNAL_MANAGED, INTERNAL, INTERNAL_MANAGED"
  }
}

variable "forwarding_rule_name" {
  description = "The name of the forwarding rule."
  type        = string
  default     = ""
}

variable "create_regional_services" {
  description = "Decides whether to create regional resources. When set to `true`, common use cases include creating regional internal and external Application Load Balancers. The `region` variable is required if this is set to `true`."
  type        = bool
  default     = false
}

variable "region" {
  description = "The region where the load balancer and its components will be created. It is required if `create_regional_services` is set to `true`"
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

variable "protocol" {
  description = "The protocol this BackendService uses for connectivity to backends. Possible values are HTTP, HTTPS, HTTP2, TCP, SSL, and UDP."
  type        = string
}

variable "ip_protocol" {
  description = "The IP protocol to which this rule applies. For regional external passthrough Network Load Balancers, valid values are L3_DEFAULT, TCP, UDP, ESP, AH, SCTP, ICMP. For regional internal passthrough Network Load Balancers, valid values are TCP, UDP, and L3_DEFAULT. For regional external and internal Application Load Balancers, TCP is the only valid option."
  type        = string
}

variable "port" {
  description = "The port that the load balancer is listening on."
  type        = number
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

variable "create_proxy" {
  description = "If true, a target http proxy and url map will be created."
  type        = bool
  default     = false
}

variable "target_http_proxies_name" {
  description = "The name of the target http proxy."
  type        = string
  default     = ""
}

variable "url_map_name" {
  description = "The name of the url map."
  type        = string
  default     = ""
}

variable "backend_service_name" {
  description = "The name of the backend service."
  type        = string
  default     = ""
}

variable "balancing_mode" {
  description = "Defines how to distribute traffic to backends. Possible values are: UTILIZATION, RATE, CONNECTION, CUSTOM_METRICS."
  type        = string
  default     = "UTILIZATION"
  validation {
    condition     = contains(["UTILIZATION", "RATE", "CONNECTION", "CUSTOM_METRICS"], var.balancing_mode)
    error_message = "Possible values are: UTILIZATION, RATE, CONNECTION, CUSTOM_METRICS."
  }
}

variable "backend_instance_group" {
  description = "The instance group that will receive traffic from the forwarding rule."
  type        = string
}

variable "backend_network_tags" {
  description = "The list of network tags to identify valid sources or targets for network firewalls."
  type        = list(string)
  default     = []
}

variable "health_check_name" {
  description = "Name of the health check. If not provided, a name will be generated using the load_balancer_name."
  type        = string
  default     = ""
}

variable "health_check_path" {
  description = "The request path of the health check. The default is /."
  type        = string
  default     = "/"
}
