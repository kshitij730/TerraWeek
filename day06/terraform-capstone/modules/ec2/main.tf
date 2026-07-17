resource "aws_instance" "web" {

  ami = var.ami

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  associate_public_ip_address = true

  vpc_security_group_ids = [

    var.security_group_id

  ]

  user_data = <<-EOF
#!/bin/bash

yum update -y

yum install nginx -y

systemctl enable nginx

systemctl start nginx

cat > /usr/share/nginx/html/index.html <<HTML

<!DOCTYPE html>

<html>

<head>

<title>TerraDeploy</title>

</head>

<body>

<h1>🚀 TerraDeploy Capstone</h1>

<h2>TrainWithShubham TerraWeek 2026</h2>

<p>Infrastructure deployed using Terraform.</p>

</body>

</html>

HTML

EOF

  tags = {

    Name = "${var.project_name}-${var.environment}-ec2"

  }

}