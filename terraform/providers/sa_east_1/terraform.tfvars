terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket     = "vpn-terragrunt-tfstate"
      key        = "${path_relative_to_include()}/terraform.tfstate"
      region     = "sa-east-1"
      encrypt    = true
      lock_table = "vpn-terragrunt"
    }
  }
}

# subnet we want to deploy into
vpc_id = "vpc-125d2475"

# subnet we want to deploy into
instance_key_name = "vpn-ssh"

# public key content
intance_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbpu2OX3fAhLsVD3nQVm2zC1yHdDMwsKlNSfhe9ZmFyrqjlQX2wqXNFa4b8b0/kO27g4as1J5foxpoaZI24uoPiIcVIhI5jjg9e7GFrbx7kJjNQgJfqUgLEj52AHjI2JvL0bu7014TBeb7XHG/BhyKfbfGoR4vOERqi5Rz1vygC6LhGBYtLCn6zv6upK/Pxg3DwW46zmd5ywipuabPRC8HQdIUFz2GpOacqgsMJg5eXmoC8lTPHz3kCqHQMY+GhSxohiAyAZaOiWn5qxZPta4V5OGeIcfVSVqCb1lfZlwZFFhjpIizL5/tFaPRag/1u1/gZo1L7fIEncmu4/TL0bf84GHJoYBqKnAkh++vfxqUc2O5g0JRDTOMUTD6jlGYdsXS5VPCQvBw//5+xh+dpWxZpx2AHI6jGNbjb3Yr7EaA8niXDwySf40HjtDGb8nqeawygzKIDqBzR2cG+2hx8V6Zk/vbA0jiQMjESZckmCeq4uAYy8cHc4t5oBgPjLIYQT8jBW2jyKbVPXyB+mZSZn/8+NCgUtlNj6OWZ87ZOQb8h98JDIw6DtflS4pJbEliI4IiqLrrFBfjy31b10wAYVmaVeDIq8ot6ZOP7vBi8QFVdhkG2s23zFGls3tOzZXnbL+sh1vXgCj/oTyD2ooCcCBICR1AZZqO9N+zivea/N4atQ== rmzamith@gmail.com"