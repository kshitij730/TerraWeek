output "instance_id" {

  description = "The ID of the EC2 Instance."

  value = aws_instance.this.id

}

output "public_ip" {

  description = "Public IPv4 address."

  value = aws_instance.this.public_ip

}

output "private_ip" {

  description = "Private IPv4 address."

  value = aws_instance.this.private_ip

}