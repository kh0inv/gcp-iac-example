locals {
  common_config = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_config    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project      = "${local.common_config.inputs.project_name}"
  region       = "${local.env_config.inputs.region}"
}
EOF
}

remote_state {
  backend = "local"

  config = {
    path = "${get_repo_root()}/opentofu-states/${path_relative_to_include()}/tofu.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
