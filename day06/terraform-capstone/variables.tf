#############################################################
# AWS Region
#############################################################

variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "ap-south-1"

}

#############################################################
# Project Name
#############################################################

variable "project_name" {

  description = "Project Name"

  type = string

  default = "terradeploy"

}

#############################################################
# Environment
#############################################################

variable "environment" {

  description = "Deployment Environment"

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

#############################################################
# EC2 Instance Type
#############################################################

variable "instance_type" {

  description = "Default EC2 Instance Type"

  type = string

  default = "t3.micro"

}

#############################################################
# Bucket Name
#############################################################

variable "bucket_name" {

  description = "Static Website Bucket"

  type = string

}