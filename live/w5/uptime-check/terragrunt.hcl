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
  display_name  = "Lamp Uptime Check 2"
  instance_name = "lamp-1-vm"
  project_id    = include.env.inputs.project_name
  zone          = include.env.inputs.zone
}
