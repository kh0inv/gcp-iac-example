terraform {
  source = "../../../modules/application-load-balancers"
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
  config_path = "../vpc_network"
}

dependency "managed-instance-group" {
  config_path = "../managed-instance-group"
}

inputs = {
  region                = include.env.inputs.region
  load_balancer_name    = format("%s-ilb", include.env.inputs.name_suffix)
  load_balancing_scheme = "INTERNAL"
  port                  = 80
  protocol              = "TCP"
  ip_protocol           = "TCP"
  network               = dependency.vpc_network.outputs.network_name
}
