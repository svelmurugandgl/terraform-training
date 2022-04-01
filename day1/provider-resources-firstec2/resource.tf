resource "aws_instance" "tftraining" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   
   depends_on = [
    aws_security_group.training-SG
  ]
   vpc_security_group_ids = [aws_security_group.training-SG.id]

}