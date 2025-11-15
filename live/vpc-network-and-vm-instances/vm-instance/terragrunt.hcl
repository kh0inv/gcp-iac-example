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
  vm_name      = "bloghost-vm-251017"
  machine_type = ""
  region       = include.env.inputs.region
  zone         = include.env.inputs.zone

  boot_disk_image = "debian-cloud/debian-11"

  metadata_startup_script = "apt-get update && apt-get install apache2 php php-mysql -y && service apache2 restart"
}
