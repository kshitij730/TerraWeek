# --- Data sources: read existing info, don't create anything ---

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# -----------------------------
# Network
# -----------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# -----------------------------
# Security Group
# -----------------------------

resource "aws_security_group" "web" {
  name        = "${var.name_prefix}-web-sg"
  description = "Allow HTTP inbound and all outbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-web-sg"
  }
}

# -----------------------------
# EC2 Instance
# -----------------------------

resource "aws_instance" "web" {

  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  # Assignment Task: depends_on
  depends_on = [
    aws_internet_gateway.igw,
    aws_route_table_association.public
  ]

  user_data = <<-EOF
#!/bin/bash
dnf install -y nginx
echo "<h1>Hello from TerraWeek 2026 🚀</h1>" > /usr/share/nginx/html/index.html
systemctl enable --now nginx
EOF

  lifecycle {

    create_before_destroy = true

    # Assignment Task
    ignore_changes = [
      tags
    ]

  }

  tags = {
    Name = "${var.name_prefix}-web"
  }
}

# ---------------------------------------------------
# Assignment Task : count Meta Argument
# ---------------------------------------------------

resource "null_resource" "count_demo" {

  count = 3

  triggers = {
    number = count.index
  }

}

# ---------------------------------------------------
# Assignment Task : for_each Meta Argument
# ---------------------------------------------------

resource "null_resource" "foreach_demo" {

  for_each = toset([
    "dev",
    "staging",
    "prod"
  ])

  triggers = {
    environment = each.key
  }

}