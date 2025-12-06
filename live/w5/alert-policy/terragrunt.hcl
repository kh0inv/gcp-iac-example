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
  display_name       = "Inbound Traffic Alert"
  project_id         = include.env.inputs.project_id
  instance_name      = dependency.vm_instance.outputs.instance_name
  notification_email = include.common.inputs.owner_email
}
