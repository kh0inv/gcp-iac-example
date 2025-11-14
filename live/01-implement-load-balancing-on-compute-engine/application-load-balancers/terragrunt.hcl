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
  load_balancer_name = format("%s-http-lb", include.env.inputs.name_suffix)

  forwarding_rule_name = format("%s-http-lb", include.env.inputs.name_suffix)
  instance_group_name  = format("%s-mig", include.env.inputs.name_suffix)
  region               = include.env.inputs.region
  ip_name              = "lb-ipv4-1"
  health_check_name    = "http-basic-check"
}
