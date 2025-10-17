locals {
  common_config = read_terragrunt_config("common.hcl")
  env_config    = read_terragrunt_config(find_in_parent_folder("env.hcl"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project_name = ${local.common_config.inputs.project_name}
  region       = ${local.env_config.inputs.region}
}
EOF
}

remote_state {
  backend = "local"

  config = {
    path = "${get_repo_root()}/tofu-states/${path_relative_to_include()}/tofu.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
