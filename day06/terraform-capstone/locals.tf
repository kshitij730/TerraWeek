locals {

  current_environment = (
    terraform.workspace == "default"
    ? var.environment
    : terraform.workspace
  )

  instance_size = (
    local.current_environment == "prod"
    ? "t3.medium"
    : local.current_environment == "staging"
    ? "t3.small"
    : "t3.micro"
  )

  common_tags = {
    Project     = var.project_name
    Environment = local.current_environment
    ManagedBy   = "Terraform"
    Challenge   = "TerraWeek"
    Owner       = "Your Name"
  }

}