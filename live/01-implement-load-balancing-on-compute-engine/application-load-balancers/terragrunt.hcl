terraform {
  source = "${get_repo_root()}/modules/application-load-balancers"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

dependency "vpc_network" {
  config_path = "../vpc-network"
}

dependency "managed_instance_group" {
  config_path = "../managed-instance-group"
}

inputs = {
  region                 = include.env.inputs.region
  load_balancer_name     = format("%s-ilb", include.env.inputs.name_suffix)
  load_balancing_scheme  = "INTERNAL"
  port                   = 80
  protocol               = "TCP"
  ip_protocol            = "TCP"
  network                = dependency.vpc_network.outputs.network
  subnetwork             = dependency.vpc_network.outputs.subnetwork
  backend_instance_group = dependency.managed_instance_group.outputs.instance_group
  backend_network_tags   = ["backend", "lb-health-check"]
  health_check_path      = "/2"
}
