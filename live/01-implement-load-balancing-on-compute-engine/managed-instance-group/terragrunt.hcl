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
  config_path = "../vpc-network"
}

inputs = {
  region = include.env.inputs.region

  instance_group_name = format("%s-mig", include.env.inputs.name_suffix)
  base_instance_name  = format("%s-vm-%s", include.env.inputs.name_suffix, "backend")
  target_size         = 3

  instance_template_name = format("%s-instance-template", include.env.inputs.name_suffix)
  machine_type           = "e2-medium"
  source_image           = "debian-cloud/debian-12"

  network              = dependency.vpc_network.outputs.network_name
  network_tags         = ["backend", "lb-health-check"]
  allocate_external_ip = false

  metadata_startup_script = file("${get_repo_root()}/scripts/primes-game/backend.sh")
}
