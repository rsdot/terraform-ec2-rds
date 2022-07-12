output "ec2_jumphost" {
  value = aws_instance.ec2_jumphost.public_ip
}
