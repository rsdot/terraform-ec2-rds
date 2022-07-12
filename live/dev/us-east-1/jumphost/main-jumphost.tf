# option 1, not free tier
data "aws_ami" "ubuntu_us_east_1" {
  most_recent = true
  owners = [ "099720109477" ] # Cannonical

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" ]
  }
}

locals {
  ami_name = "ami-09d56f8956ab235b3" # option 2, free tier for ubuntu 22.04
  # ami_name = "ami-08d4ac5b634553e16" # option 3, free tier for ubuntu 20.04
}

resource "aws_instance" "ec2_jumphost" {
  # ami                         = data.aws_ami.ubuntu_us_east_1.id
  ami                         = local.ami_name
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [ 
    data.terraform_remote_state.network.outputs.sg_allowssh, 
    data.terraform_remote_state.network.outputs.sg_allowmysql_from_sg_allowaurora
  ]
  subnet_id                   = data.terraform_remote_state.network.outputs.sb_public
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"

  root_block_device {
    volume_size               = 30

    tags = {
      Name = "${var.namespace}-ec2-jumphost-ebs-root"
      migrationteam = var.namespace
    }
  }

  tags = {
    Name = "${var.namespace}-ec2-jumphost"
    migrationteam = var.namespace
  }
}

