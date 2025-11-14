terraform {
  source = "../../../modules/${basename(get_terragrunt_dir())}"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}

inputs = {
  vpc_network_name        = "mynetwork"
  auto_create_subnetworks = true
}
