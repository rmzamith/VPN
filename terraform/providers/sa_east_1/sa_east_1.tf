variable vpc_id {
  description = "The ID of the VPC in which everything will be provisioned"
}

variable instance_key_name {
  description = "The name of the key to access the server instances"
}

provider "aws" {
  region = "sa-east-1"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "compute" {
  source = "../../modules/compute"

  vpc_id               = "${var.vpc_id}"
  instance_key_name    = "${var.instance_key_name}"
}
