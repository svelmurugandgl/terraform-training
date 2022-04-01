
# Creating a Security Group for application server
resource "aws_security_group" "applicationserver-SG" {

  depends_on = [
    aws_vpc.application,
    aws_subnet.applicationsubnet,

  ]

  description = "HTTP, PING, SSH"

  name = "tftraining-Appserver-sg-${random_string.random_name.result}"

  vpc_id = aws_vpc.application.id

  ingress {
    description = "HTTP for application server"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP for application server"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from application server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_security_group" "securitygroup" {
  name        = "tftraining Database SG"
  description = "Database SG"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = [format("%s/32", aws_instance.applicationserver.private_ip)]
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "tftraining-db-server-sg-${random_string.random_name.result}"
  }
}
