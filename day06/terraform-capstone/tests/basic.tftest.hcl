#############################################################
# Terraform Native Tests
#############################################################

#############################################################
# Test 1 - Validate Workspace
#############################################################

run "validate_workspace" {

  command = plan

  variables {

    bucket_name = "terradeploy-workspace-test-123456"

  }

  assert {

    condition = output.workspace != ""

    error_message = "Workspace output should not be empty."

  }

}

#############################################################
# Test 2 - Validate Infrastructure Outputs
#############################################################

run "validate_outputs" {

  command = apply

  variables {

    bucket_name = "terradeploy-output-test-654321"

  }

  assert {

    condition = output.instance_id != ""

    error_message = "Instance ID should not be empty."

  }

  assert {

    condition = output.vpc_id != ""

    error_message = "VPC ID should not be empty."

  }

  assert {

    condition = output.bucket_name != ""

    error_message = "Bucket name should not be empty."

  }

}

#############################################################
# Test 3 - Invalid Environment
#############################################################

run "invalid_environment" {

  command = plan

  variables {

    bucket_name = "terradeploy-invalid-test-789456"

    environment = "banana"

  }

  expect_failures = [

    var.environment

  ]

}