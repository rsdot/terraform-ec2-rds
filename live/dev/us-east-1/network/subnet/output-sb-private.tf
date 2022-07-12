output "sb_private" {
  value = { for sb in aws_subnet.sb_private : sb.availability_zone => sb.id }
  description = <<-EOF
  return map(string) type, for example:
  {
    "us-east-1a" = "sb-xxxxx"
    "us-east-1b" = "sb-xxxxx"
    ...
  }
  EOF
}

