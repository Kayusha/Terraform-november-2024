provider aws {
    region = var.region
}

variable region {
    default = ""
    type = string 
}

    resource "aws_key_pair" "deployer" {
        key_name = "deployer-key"
        public_key = file("~/.ssh/id_rsa.pub")

        tags = {
            Team = "DevOps"
            Environment = "Dev"
            Owner = "Adilet"

        }

    
    
}