provider "aws" {
  region = "us-east-1"  
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for web servers"

  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_servers" {
  count         = 3
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  
  key_name = "my-laptop-key"  
  
  tags = {
    Name = "web-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello, World!" > /var/www/html/index.html
              EOF

  user_data_replace_on_change = true
}


output "instance_public_ips" {
  value = aws_instance.web_servers[*].public_ip
}