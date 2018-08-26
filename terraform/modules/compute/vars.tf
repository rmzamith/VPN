variable "vpc_id" {
  description = "The ID of the VPC with the subnets in which EC2 instances will be created in"
}

variable instance_key_name {
  description = "The name of the key to access the server instances"
}

variable intance_public_key {
  description = "The public key used to access the server instances"
}