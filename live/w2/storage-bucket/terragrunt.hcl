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
  bucket_name = format("%s-bucket-%s", include.env.inputs.name_suffix, 1)
  location    = "US-CENTRAL1"

  uniform_bucket_level_access = true
  role_entity_list = [
    "OWNER:student-03-a90fa6d5c1e0@qwiklabs.net",
    "READER:allUsers"
  ]
}
