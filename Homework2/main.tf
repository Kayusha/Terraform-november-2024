provider aws {
    region = "us-east-1"
}
 resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_s3_bucket" "example" {
  bucket_prefix = "kaizen-gulkaiyrnam-"
  force_destroy = true 
}

resource "aws_s3_bucket" "kaizen-kayu" {
  bucket = "kaizen-kayu"
}

resource "aws_s3_bucket" "kaizen-kayu2" {
  bucket = "kaizen-kayu2"
}

resource "aws_s3_bucket" "kaizen-kayu3" {
  bucket = "kaizen-kayu3"
}

resource "aws_s3_object" "object" {
  depends_on = [aws_s3_bucket.example]
  bucket     = aws_s3_bucket.example.bucket
  key        = "main.tf"
  source     = "main.tf"
}

resource "aws_iam_user" "lb" {
  for_each = toset(["jihuo", "sana", "momo", "dahyun"])
  name     = each.value
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"
  users = [
    for i in aws_iam_user.lb : i.name 
  ]
  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "twice"
}