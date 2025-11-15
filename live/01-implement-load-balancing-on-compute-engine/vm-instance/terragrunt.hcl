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

dependency "vpc_network" {
  config_path = "../vpc_network"
}

inputs = {
  vm_name      = format("%s-vm-%s", include.env.inputs.name_suffix, "frontend")
  machine_type = "e2-standard-2"
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_image = "debian-cloud/debian-12"

  network      = dependency.vpc_network.outputs.network_name
  network_tags = ["frontend"]
  allow_http   = true

  metadata_startup_script = file("${get_repo_root()}/scripts/primes-game/frontend.sh")
}
