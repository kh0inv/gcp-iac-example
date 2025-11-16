terraform {
  source = "${get_repo_root()}/modules/vm-instance"
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
  vm_name      = "gcelab-window"
  machine_type = "e2-medium"
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_size  = 50
  boot_disk_image = "windows-cloud/windows-2022"
}
