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

dependency "vm_instance" {
  config_path = "../vm-instance"
}

inputs = {
  display_name = "Lamp Uptime Check"
  project_id   = include.env.inputs.project_id
  zone         = include.env.inputs.zone
  instance_id  = dependency.vm_instance.outputs.instance_id
}
