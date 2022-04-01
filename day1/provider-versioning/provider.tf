# provider "aws" {
#   region     = "us-west-2"
#   version    = ">=3.10,<=4.7"
# }

# provider "aws" {
#   region     = "us-west-2"
#   version    = "~>3.0"
# }

# provider "aws" {
#   region     = "us-west-2"
#   version    = "<=4.8"
# }


# provider "aws" {
#   region     = "us-west-2"
#   version    = ">=3.7"
# }

provider "aws" {
  region     = "us-west-2"
}

terraform {
  required_version = ">= 0.13.0"
}



resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}