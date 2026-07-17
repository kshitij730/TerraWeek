####################################################
# Variables
####################################################

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging or prod."
  }
}

variable "app_name" {
  description = "Application name."
  type        = string
  default     = "terraweek"
}

####################################################
# Local Values
####################################################

locals {

  # Environment is driven by the variable (better for testing)
  current_environment = var.environment

  # Keep the active Terraform workspace available separately
  current_workspace = terraform.workspace

  # Choose instance type based on environment
  instance_type = local.current_environment == "prod" ? "t3.medium" : "t3.micro"

  # Resource naming convention
  name_prefix = "${var.app_name}-${local.current_environment}"
}

####################################################
# Random Resource
####################################################

resource "random_pet" "id" {
  prefix = local.name_prefix
  length = 2
}

####################################################
# Outputs
####################################################

output "resource_name" {
  description = "Generated resource name."
  value       = random_pet.id.id
}

output "instance_type" {
  description = "Instance type selected based on workspace."
  value       = local.instance_type
}

output "workspace" {
  description = "Current Terraform workspace."
  value       = local.current_workspace
}