#############################################################
# Remote Backend
#############################################################

terraform {

  backend "s3" {

    bucket = "terraform-capstone-ksh730-test"

    key = "terraform-capstone/terraform.tfstate"

    region = "ap-south-1"

    use_lockfile = true

  }

}