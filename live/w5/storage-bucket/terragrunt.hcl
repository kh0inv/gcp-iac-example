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
  name = format("%s-bucket", include.env.inputs.name_suffix)
  # name = include.env.inputs.project_id
  location = include.env.inputs.region

  uniform_bucket_level_access = true
  iam_members = [
    { role = "roles/storage.objectViewer", member = "allUsers" },
    { role = "roles/storage.admin", member = "user:student-00-dd08da140587@qwiklabs.net" }
  ]
}
