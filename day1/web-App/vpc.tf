# Creating a VPC!
resource "aws_vpc" "application" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tftraining1-${random_string.random_name.result}"
  }
}


resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "tftraining2-${random_string.random_name.result}"
  }
}
