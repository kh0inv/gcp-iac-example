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
  # bucket_name = format("%s-bucket-%s", include.env.inputs.name_suffix, 1)
  bucket_name = include.env.inputs.project_name
  location    = include.env.inputs.region

  # uniform_bucket_level_access = false
  # role_entity_list = [
  #   { role = "OWNER", entity = "student-03-49af286529b5@qwiklabs.net" },
  #   { role = "READER", entity = "allUsers" }
  # ]

  uniform_bucket_level_access = true
  iam_members = [
    { role = "roles/storage.objectViewer", member = "allUsers" },
    { role = "roles/storage.admin", member = "user:student-03-49af286529b5@qwiklabs.net" }
  ]
}
