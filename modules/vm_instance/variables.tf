variable "vpc_network_name" {
  description = "The name of the VPC network."
  type        = string
  default     = "vpc-network-example"
}

variable "vpc_network_routing_mode" {
  description = "Routing mode of the VPC. A 'GLOBAL' routing mode can have adverse impacts on load balancers. Prefer 'REGIONAL'."
  type        = string
  default     = "REGIONAL"
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9"
  type        = bool
  default     = false
}
