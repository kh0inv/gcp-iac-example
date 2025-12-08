terraform {
  source = "${get_repo_root()}/modules/cloud-run"
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
  name               = "store-service"
  location           = include.env.inputs.region
  max_instance_count = 2
  template_image     = "gcr.io/qwiklabs-resources/gsp724-store-service"

  allow_public_access = true
}
