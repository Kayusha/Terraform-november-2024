# terraform {
#   backend "s3" {
#     bucket = "kayusha92"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "lock-state"
#   }
# }
