#############################################################
# AWS VPC
#############################################################

#############################################################
# Random Bucket Suffix
#############################################################

resource "random_pet" "bucket" {

  length = 2

}

#############################################################
# VPC (Registry Module)
#############################################################

module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${var.project_name}-${local.current_environment}"

  cidr = "10.0.0.0/16"

  azs = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  # Assign Public IP to instances launched in public subnet
  map_public_ip_on_launch = true

  enable_nat_gateway = false
  single_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags

}

#############################################################
# Security Group Module
#############################################################

module "security_group" {

  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id

  project_name = var.project_name

  environment = local.current_environment

}

#############################################################
# EC2 Module
#############################################################

module "ec2" {

  source = "./modules/ec2"

  ami = data.aws_ami.amazon_linux.id

  instance_type = local.instance_size

  subnet_id = module.vpc.public_subnets[0]

  security_group_id = module.security_group.security_group_id

  project_name = var.project_name

  environment = local.current_environment

}

#############################################################
# Static Website / Artifact Bucket
#############################################################

module "static_site" {

  source = "./modules/static_website"

  bucket_name = var.bucket_name

  tags = local.common_tags

}


