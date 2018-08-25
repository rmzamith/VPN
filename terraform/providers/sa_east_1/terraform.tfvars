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
instance_key_name = "ssh-raphael"

# public key content
intance_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA2jxeXn8DuKMVg2QUBnFjbNTIjQcX7tcL2NwWK4XFzytw5bBOplBI8Y7y4+SXYYFh8YMPCxjFspJ+Pi6aB0DaAZI0KuhR5QS+WjPwz7pnsc2o1RmyGVgTJJFkQEx0kMUfj8mozdShSnRHN9aU3EJ/jydp+7+M6pV4rWqsljS0c+UfiMm09ooOQvI3WzTwOWD6L8Y5zN6h9R0MJEQDxbH+3GzsxA8bRTaGHukJGG2TmHb1zUB8+XcjVTulp2G6Ef+xBPJYycVZIjVU23e48Ch29X2hL0Jfb4ox0wT3MLL1Kf3Jk7RsCKKNcnRHn7RjjFSy5DleHRZLuaWYhdMMkElbXw== rsa-key-20160912"