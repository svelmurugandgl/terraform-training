resource "aws_vpc_peering_connection" "primary2secondary" {
  vpc_id      = aws_vpc.application.id
  peer_vpc_id = aws_vpc.vpc.id
  auto_accept = true
}

resource "aws_route" "primary2secondaryroute" {
  route_table_id            = aws_route_table.applicationsubnet-RT1.id
  destination_cidr_block    = aws_vpc.vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}


resource "aws_route" "secondary2primaryroute" {
  route_table_id            = aws_route_table.nat_gateway.id
  destination_cidr_block    = aws_vpc.application.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}

resource "aws_route" "secondary2primaryroute1" {
  route_table_id            = aws_route_table.instance.id
  destination_cidr_block    = aws_vpc.application.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}