module "november-2024" {
  source  = "Kayusha/november-2024/module"
  version = "1.0.0"
  region = "us-east-1"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {}
    Name = var.igw_name  }
}
