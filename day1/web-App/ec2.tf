#Generating Key Pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_iam_instance_profile" "application_profile" {
  name       = "application_profile-${random_string.random_name.result}"
  role       = aws_iam_role.application_role.id
  depends_on = [aws_iam_role.application_role]
}


# Creating an AWS instance for the sensitiveserver!
resource "aws_instance" "applicationserver" {

  depends_on = [
    aws_vpc.application,
    aws_subnet.applicationsubnet,
    aws_security_group.applicationserver-SG
  ]

  ami                    = "ami-03d5c68bab01f3496"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.applicationsubnet.id
  iam_instance_profile   = aws_iam_instance_profile.application_profile.name
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.applicationserver-SG.id]
  user_data              = file("application.sh")
  tags = {
    Name = "application server"
  }

}



resource "null_resource" "applicationserver" {
  depends_on = [aws_instance.applicationserver]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = tls_private_key.example.private_key_pem
    host        = aws_instance.applicationserver.public_ip
    timeout     = "1m"
  }


  provisioner "file" {
    source      = "application"
    destination = "/tmp/"
  }
}




resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "ssh" {
  key_name   = "DummyMachine"
  public_key = tls_private_key.ssh.public_key_openssh
}







resource "aws_instance" "ec2instance" {


  instance_type = "t2.micro"
  # ami = "${data.aws_ami.amz_linux.id}"
  ami                     = "ami-03d5c68bab01f3496" # https://cloud-images.ubuntu.com/locator/ec2/ (Ubuntu)
  subnet_id               = aws_subnet.instance.id
  security_groups         = [aws_security_group.securitygroup.id]
  key_name                = aws_key_pair.ssh.key_name
  disable_api_termination = false
  ebs_optimized           = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name" = "database"
  }

  user_data = file("install_redis.sh")
}



resource "aws_instance" "ec2jumphost" {
  instance_type           = "t2.micro"
  ami                     = "ami-03d5c68bab01f3496"
  subnet_id               = aws_subnet.nat_gateway.id
  security_groups         = [aws_security_group.securitygroup.id]
  key_name                = aws_key_pair.ssh.key_name
  disable_api_termination = false
  ebs_optimized           = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name" = "Basion host"
  }

}
