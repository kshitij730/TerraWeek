####################################################
# Dev Environment
####################################################

run "dev_environment" {

  command = plan

  variables {
    environment = "dev"
  }

  assert {
    condition     = output.instance_type == "t3.micro"
    error_message = "Dev should use t3.micro."
  }
}

####################################################
# Prod Environment
####################################################

run "prod_environment" {

  command = plan

  variables {
    environment = "prod"
  }

  assert {
    condition     = output.instance_type == "t3.medium"
    error_message = "Prod should use t3.medium."
  }
}

####################################################
# Resource Name
####################################################

run "resource_prefix" {

  command = apply

  variables {
    app_name    = "tws"
    environment = "dev"
  }

  assert {
    condition     = startswith(output.resource_name, "tws-")
    error_message = "Resource name should start with tws-."
  }
}

####################################################
# Workspace Output
####################################################

run "workspace_exists" {

  command = plan

  assert {
    condition     = output.workspace != ""
    error_message = "Workspace output missing."
  }
}

####################################################
# Invalid Environment
####################################################

run "invalid_environment" {

  command = plan

  variables {
    environment = "banana"
  }

  expect_failures = [
    var.environment
  ]
}