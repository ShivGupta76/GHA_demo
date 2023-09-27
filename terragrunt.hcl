terraform {
  # source = "./terraform"  # Specify the path to your Terraform configuration directory
  source = "git::https://github.com/ShivGupta76/tf-demo.git//modules/my_gce?ref=main"
  #"git::https://github.com/ShivGupta76/tf-demo.git//modules//my_gce?ref=1.0.16"
}

locals {
  gcp_project = "zinc-arc-396916"
  #credentials   = "./zinc-arc-396916-9d8a70ea2239.json"
}
inputs = {
  project       = "zinc-arc-396916"
  region        = "us-west4"
  zone          = "us-west4-a"
  #credentials   = local.credentials
  instance_name = "my-terragrunt-vm6"
  machine_type  = "e2-medium"
  image         = "ubuntu-os-cloud/ubuntu-2004-lts"
}

remote_state {
  backend = "gcs"
  config = {
    bucket         = "tf-states-demo"
    prefix         = "${path_relative_to_include()}/tf-tg-gha.tfstate1"
    #credentials    = local.credentials
    project        = local.gcp_project  # Your GCP project ID    
  }
}