
output "webserverPublic_ip" {
  value = aws_instance.applicationserver.public_ip
}