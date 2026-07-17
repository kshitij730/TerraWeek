#############################################################
# VPC Outputs
#############################################################

output "vpc_id" {

  description = "VPC ID"

  value = module.vpc.vpc_id

}

output "public_subnets" {

  description = "Public Subnets"

  value = module.vpc.public_subnets

}

#############################################################
# EC2
#############################################################

output "instance_id" {

  description = "EC2 Instance ID"

  value = module.ec2.instance_id

}

output "ec2_public_ip" {

  description = "Public IP"

  value = module.ec2.public_ip

}

#############################################################
# Security Group
#############################################################

output "security_group_id" {

  description = "Security Group"

  value = module.security_group.security_group_id

}

#############################################################
# S3
#############################################################

output "bucket_name" {

  description = "Artifact Bucket"

  value = module.static_site.bucket_name

}

#############################################################
# Environment
#############################################################

output "workspace" {

  description = "Current Workspace"

  value = terraform.workspace

}