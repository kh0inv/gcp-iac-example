terraform {
  source = "${get_repo_root()}/modules/${basename(get_terragrunt_dir())}"
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

inputs = {
  network_name            = format("%s-vpc", include.env.inputs.name_suffix)
  auto_create_subnetworks = false

  subnetwork_name          = format("%s-vpc-subnet", include.env.inputs.name_suffix)
  subnetwork_ip_cidr_range = "10.0.0.0/24"
}
