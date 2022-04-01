# Creating an Route Table for the public subnet!
resource "aws_route_table" "applicationsubnet-RT1" {
  depends_on = [
    aws_vpc.application,
    aws_internet_gateway.Internet_Gateway
  ]

  vpc_id = aws_vpc.application.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "tftraining-public-route-for-application-subnet-${random_string.random_name.result}"
  }
}

# Creating a resource for the Route Table Association for VPC1!
resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.application,
    aws_subnet.applicationsubnet,
    aws_route_table.applicationsubnet-RT1
  ]
  subnet_id      = aws_subnet.applicationsubnet.id
  route_table_id = aws_route_table.applicationsubnet-RT1.id
}



resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "nat_gateway" {
  subnet_id      = aws_subnet.nat_gateway.id
  route_table_id = aws_route_table.nat_gateway.id
}


resource "aws_route_table" "instance" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "instance" {
  subnet_id      = aws_subnet.instance.id
  route_table_id = aws_route_table.instance.id
}
