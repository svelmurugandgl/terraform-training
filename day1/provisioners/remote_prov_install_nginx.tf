
# variable "key_name" { default = "trainingterraform" }



# resource "tls_private_key" "training" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }


# resource "aws_key_pair" "generated_key" {
#   key_name   = var.key_name
#   public_key = tls_private_key.training.public_key_openssh
# }

# resource "aws_instance" "mytraining" {
#    ami = "ami-082b5a644766e0e6f"
#    instance_type = "t2.micro"
#    key_name               = var.key_name
#    vpc_security_group_ids  = [aws_security_group.port_twentytwo.id]

#    provisioner "remote-exec" {
#      inline = [
#        "sudo amazon-linux-extras install -y nginx1.12",
#        "sudo systemctl start nginx"
#      ]

#    connection {
#      type = "ssh"
#      user = "ec2-user"
#      agent       = false
#      private_key = tls_private_key.training.private_key_pem
#      host = aws_instance.mytraining.public_ip
#      timeout     = "1m"
#    }
#    }
# }

# ### NOTE - Adding a new security group resource to allow the terraform provisioner from laptop to connect to EC2 Instance via SSH.

# resource "aws_security_group" "port_twentytwo" {
#   name        = "allow_ssh"
#   description = "Allow SSH inbound traffic"

#   ingress {
#     description = "SSH into VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "port 80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     description = "Outbound Allowed"
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
