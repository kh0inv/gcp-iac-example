terraform {
  source = "../../modules/${basename(get_terragrunt_dir())}"
}

include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  bucket_name = "test-abc-20251016pp"

  gcp_project_id        = include.root.inputs.gcp_project_id
  network_name          = dependency.network.outputs.network.name
  vpc_subnetwork_name   = "projects/${include.root.inputs.shared_vpc_project_id}/regions/${include.root.inputs.gcp_region}/subnetworks/odin-subnetwork"
  environment           = include.root.inputs.env
  region                = include.root.inputs.gcp_region
  instance_name         = local.name
  boot_disk_device_name = local.name
  labels = merge(
    {
      component = "${local.name}-gce"
    },
    include.common.inputs.labels,
  )
}
