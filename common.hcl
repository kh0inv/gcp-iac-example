inputs = {
  project_name = "gcp-example-project"
  region       = "us-west1"

  labels = {
    provisioned-by = "tofu-terragrunt"
    owned-by       = "infra-team"
  }
}
