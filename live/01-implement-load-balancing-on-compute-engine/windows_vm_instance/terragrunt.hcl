terraform {
  source = "../../../modules/vm_instance"
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
  vm_name      = "gcelab-window-vm"
  machine_type = "e2-medium"
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_image = "windows-cloud/windows-2022"
}
