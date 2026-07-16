####################################################
# Instance Name
####################################################

variable "name" {

  description = "Logical name of the EC2 instance."

  type = string

}

####################################################
# Instance Type
####################################################

variable "instance_type" {

  description = "AWS EC2 Instance Type."

  type = string

  default = "t2.micro"

}

####################################################
# Environment
####################################################

variable "environment" {

  description = "Deployment Environment."

  type = string

  default = "dev"

  validation {

    condition = contains(

      [

        "dev",

        "staging",

        "prod"

      ],

      var.environment

    )

    error_message = "Environment must be dev, staging or prod."

  }

}

####################################################
# AMI
####################################################

variable "ami" {

  description = "Amazon Machine Image ID."

  type = string

  validation {

    condition = startswith(

      var.ami,

      "ami-"

    )

    error_message = "AMI should start with 'ami-'."

  }

}

####################################################
# Subnet
####################################################

variable "subnet_id" {

  description = "Subnet ID."

  type = string

}

####################################################
# Security Groups
####################################################

variable "vpc_security_group_ids" {

  description = "Security Group IDs."

  type = list(string)

}

####################################################
# Tags
####################################################

variable "tags" {

  description = "Additional Tags."

  type = map(string)

  default = {}

}