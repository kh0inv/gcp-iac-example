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
  service_name             = "cloudrun-service"
  location                 = include.env.inputs.region
  max_instance_count       = 5
  template_container_image = "us-docker.pkg.dev/cloudrun/container/hello"

  service_account_id   = "cloud-run-pubsub-invoker"
  service_account_name = "Cloud Run Pub/Sub Invoker"
}
