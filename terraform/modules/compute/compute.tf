data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aws-ubuntu-vpn*"]
  }
}

data "aws_subnet_ids" "all_vpc_subnets" {
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "vpn_sg" {
  name        = "vpn-sg"
  description = "VPN inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Application = "vpn"
    Name        = "vpn-sg"
  }
}

resource "aws_eip" "vpn_ip" {
}

resource "aws_key_pair" "vpn-key" {
  key_name   = "${var.instance_key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_instance" "vpn_app" {
  ami                    = "${data.aws_ami.ami.id}"
  instance_type          = "m4.large"
  key_name               = "${var.instance_key_name}"
  vpc_security_group_ids = ["${aws_security_group.vpn_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.all_vpc_subnets.ids, count.index)}"
  depends_on             = ["aws_eip.vpn_ip"]

  tags {
    Application = "vpn"
    Name        = "vpn-app"
  }
  provisioner "local-exec" {
    command = "echo PUBLIC_IP=\"${aws_eip.vpn_ip.public_ip}\" >> /ops/config.sh"
  }
  provisioner "local-exec" {
    command = "sh /ops/openvpn.sh"
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.vpn_app.id}"
  allocation_id = "${aws_eip.vpn_ip.id}"
}
