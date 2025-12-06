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
  vm_name      = "lamp-1-vm"
  machine_type = "e2-medium"
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_image = "debian-cloud/debian-12"

  network      = "default"
  subnetwork   = "default"
  network_tags = ["frontend"]
  allow_http   = true

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 php7.0 && sudo service apache2 restart"
}
