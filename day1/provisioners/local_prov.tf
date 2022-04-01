resource "aws_instance" "mytraining1" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"

   provisioner "local-exec" {
    command = "echo ${aws_instance.mytraining1.public_ip} >> public_ip.txt"
  }
}
