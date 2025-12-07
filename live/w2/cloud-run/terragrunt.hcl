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
  name               = "billing-service"
  location           = include.env.inputs.region
  max_instance_count = 2
  template_image     = "gcr.io/qwiklabs-resources/gsp723-parking-service"

  allow_unauthenticated        = false
  invoker_service_account_name = "Billing Initiator"
}
