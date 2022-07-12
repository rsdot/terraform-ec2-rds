#--------------------------------------------------------------------------------
# private networks
#--------------------------------------------------------------------------------
resource "aws_subnet" "sb_private" {
  for_each = var.sb_private_cidr_block

  vpc_id            = var.vpc
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "${var.namespace}-sb-private-${each.key}"
    migrationteam = var.namespace
  }
}

