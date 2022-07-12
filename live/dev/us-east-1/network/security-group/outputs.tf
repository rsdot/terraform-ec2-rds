output "sg_allowssh" {
  value = aws_security_group.sg_allowssh.id
}

output "sg_allowaurora" {
  value = aws_security_group.sg_allowaurora.id
}

output "sg_allowmysql_from_sg_allowaurora" {
  value = aws_security_group.sg_allowmysql_from_sg_allowaurora.id
}

