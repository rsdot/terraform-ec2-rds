resource "aws_db_subnet_group" "sb_aurora" {
  name        = "${var.namespace}-sb-aurora"
  subnet_ids  = values(aws_subnet.sb_private)[*].id
  description = "aurora db subnet group"

  tags = {
    Name = "${var.namespace}-sb-aurora"
    migrationteam = var.namespace
  }
}

