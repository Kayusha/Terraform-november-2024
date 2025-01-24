variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "SSH Key Name"
  type        = string
  default     = "my-ec2-key"
}

variable "ports" {
  description = "Inbound ports to open"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 Instance"
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2 Instance"
  type        = string
  default     = "my-instance"
}

# Provider
provider "aws" {
  region = var.region
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "allow_ports" {
  name        = "allow_specified_ports"
  description = "Allow specified inbound traffic"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.allow_ports.id]

  tags = {
    Name = var.instance_name
  }
}

# Outputs
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}