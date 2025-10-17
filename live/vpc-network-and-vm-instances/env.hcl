inputs {
  env_name = "vpc-network-and-vm-instances"
  region   = "us-west1"
  zone     = "us-west1c"

  labels = {
    environment = input.env_name
  }
}
