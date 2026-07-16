####################################################
# Reusable EC2 Module
####################################################

resource "aws_instance" "this" {

  ami = var.ami

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids

  lifecycle {

    create_before_destroy = true

  }

  tags = merge(

    {

      Name = "${var.environment}-${var.name}"

      Environment = var.environment

      Module = "ec2_instance"

      ManagedBy = "Terraform"

    },

    var.tags

  )

}