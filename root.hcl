locals {
  common_configs = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_configs    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  default_labels = try(merge(local.common_configs.inputs.labels, local.env_configs.inputs.labels), {})
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project      = "${local.env_configs.inputs.project_name}"
  region       = "${local.env_configs.inputs.region}"
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
primes