####################################################
# Shared Data Sources (Resolved Only Once)
####################################################

data "aws_ami" "al2023" {

  most_recent = true
  owners      = ["amazon"]

  filter {

    name = "name"

    values = [
      "al2023-ami-2023.*-x86_64"
    ]

  }

}

####################################################
# Default Networking
####################################################

data "aws_vpc" "default" {

  default = true

}

data "aws_subnets" "default" {

  filter {

    name = "vpc-id"

    values = [
      data.aws_vpc.default.id
    ]

  }

}

data "aws_security_group" "default" {

  vpc_id = data.aws_vpc.default.id

  name = "default"

}

####################################################
# Local Values
####################################################

locals {

  subnet_id = data.aws_subnets.default.ids[0]

  security_group_ids = [
    data.aws_security_group.default.id
  ]

}

####################################################
# Root Module
####################################################

module "web_server" {

  source = "./modules/ec2_instance"

  name = "web"

  instance_type = "t2.micro"

  environment = "dev"

  ami = data.aws_ami.al2023.id

  subnet_id = local.subnet_id

  vpc_security_group_ids = local.security_group_ids

  tags = {

    Role = "frontend"

    ManagedBy = "Terraform"

  }

}

####################################################
# Module Composition using for_each
####################################################

module "servers" {

  source = "./modules/ec2_instance"

  for_each = toset([
    "app",
    "worker",
    "cache"
  ])

  name = each.key

  instance_type = "t2.micro"

  environment = "dev"

  ami = data.aws_ami.al2023.id

  subnet_id = local.subnet_id

  vpc_security_group_ids = local.security_group_ids

  tags = {

    Role = each.key

    ManagedBy = "Terraform"

  }

}