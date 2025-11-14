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

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

dependency "vpc_network" {
  config_path = "../vpc_network"
}

inputs = {
  vm_name      = format("%s-vm-%s", include.env.inputs.name_suffix, 1)
  machine_type = "e2-medium"
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_image = "debian-cloud/debian-12"

  network = dependency.vpc_network.outputs.network_name

  allow_http  = true
  allow_https = true

  metadata_startup_script = "apt-get update && sudo apt-get install nginx -y"
}
