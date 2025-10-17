terraform {
  source = "../../modules/${basename(get_terragrunt_dir())}"
}

include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  vpc_network_name        = "test-vpc-1"
  auto_create_subnetworks = true
}
