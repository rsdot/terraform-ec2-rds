#--------------------------------------------------------------------------------
# public network for us-east-1a
#--------------------------------------------------------------------------------
resource "aws_subnet" "sb_public" {
  vpc_id            = var.vpc
  availability_zone = "us-east-1a"
  cidr_block        = var.sb_public_cidr_block

  tags = {
    Name = "${var.namespace}-sb-public"
    migrationteam = var.namespace
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id            = var.vpc

  tags = {
    Name = "${var.namespace}-vpc-igw"
    migrationteam = var.namespace
  }
}

resource "aws_route_table" "rt_public_us_east_1a" {
  vpc_id            = var.vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "${var.namespace}-rt-public-us-east-1a"
    migrationteam = var.namespace
  }
}

resource "aws_route_table_association" "rta_public_us_east_1a" {
  subnet_id      = aws_subnet.sb_public.id
  route_table_id = aws_route_table.rt_public_us_east_1a.id
}

