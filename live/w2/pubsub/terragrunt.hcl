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

dependency "cloud_run" {
  config_path = "../cloud-run"
}

inputs = {
  pubsub_topic_name               = "myRunTopic"
  pubsub_subscription_name        = "myRunSubscription "
  push_endpoint                   = dependency.cloud_run.outputs.service_url
  push_auth_service_account_email = dependency.cloud_run.invoker_service_account_email
  enable_push_authentication      = true
}
