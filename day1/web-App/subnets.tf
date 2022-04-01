
# Creating Public subnet for VPC 1!
resource "aws_subnet" "applicationsubnet" {
  depends_on = [
    aws_vpc.application
  ]
  vpc_id = aws_vpc.application.id

  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"

  map_public_ip_on_launch = true

  tags = {
    Name = "tftraining-application-Subnet"
  }
}

data "aws_availability_zones" "available" {}


resource "aws_subnet" "instance" {
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.1.1.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name = "tftraining-database-Subnet"
  }
}

resource "aws_subnet" "nat_gateway" {
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.1.2.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "tftraining-Public-SubnetNAT"
  }
}
