terraform {
  source = "../../../modules/${basename(get_terragrunt_dir())}"
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

dependency "vpc_network" {
  config_path = "../vpc_network"
}

inputs = {
  instance_group_name    = format("%s-mig", include.env.inputs.name_suffix)
  region                 = include.env.inputs.region
  base_instance_name     = format("%s-vm", include.env.inputs.name_suffix)
  target_size            = 2
  instance_template_name = format("%s-instance-template", include.env.inputs.name_suffix)
  machine_type           = "e2-medium"
  network_tags           = ["http-server", "https-server"]

  source_image = "debian-cloud/debian-12"

  network = dependency.vpc_network.outputs.network_name

  metadata_startup_script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y nginx-light jq

      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
      METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')

      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      Metadata: $METADATA
      </pre>
      EOF
    EOF1
}
