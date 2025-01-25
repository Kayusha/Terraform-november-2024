# Terraform-november-2024
```hcl 
   module "november-2024" {
   sourse = "kaizenacademy/november-2024/module"
   version = "3.0.0"
   region = "us-east-1"
   vpc_cidr = "10.0.0.0/16" # Replace with your values
   subnet_cidr = "10.0.1.0/24" Replace with your values
   iqw_name= "Kaizen" Replace with your values
   } 