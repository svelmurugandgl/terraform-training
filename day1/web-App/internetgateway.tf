# Creating an Internet Gateway for the VPC1
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.application,
    aws_subnet.applicationsubnet,

  ]
  # VPC in which it has to be created!
  vpc_id = aws_vpc.application.id

  tags = {
    Name = "tftraining-IGW-${random_string.random_name.result}"
  }
}

resource "aws_internet_gateway" "nat_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "tftraining-Public-SubnetNAT-Gateway"
  }
}
