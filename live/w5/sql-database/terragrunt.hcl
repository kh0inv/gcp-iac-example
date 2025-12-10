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
  name     = format("%s-sql", include.env.inputs.name_suffix)
  location = include.env.inputs.region

  database_version = "MYSQL_8_0"
  root_password    = "GLkTU[Rf&321FS~C"

  settings = {
    tier                  = "db-custom-8-32768"
    edition               = "ENTERPRISE"
    availability_type     = "REGIONAL"
    disk_autoresize_limit = 250

    location_preference = {
      zone = "${include.env.inputs.region}-b"
    }
  }
}
