# vim: fdm=marker fdc=2

# security group allow ssh{{{
resource "aws_security_group" "sg_allowssh" {
  vpc_id      = var.vpc
  name        = "${var.namespace}-sg-allowssh"
  description = "allow ssh inbound traffic"

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  #
  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # } 

  tags = {
    Name = "${var.namespace}-sg-allowssh"
    migrationteam = var.namespace
  }
}

resource "aws_security_group_rule" "sgr_ingress_allowssh" {
  type = "ingress"
  security_group_id = aws_security_group.sg_allowssh.id
  
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sgr_egress_allowssh" {
  type = "egress"
  security_group_id = aws_security_group.sg_allowssh.id
  
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
/*}}}*/

# security group for allow aurora{{{
resource "aws_security_group" "sg_allowaurora" {
  vpc_id      = var.vpc
  name        = "${var.namespace}-sg-allowaurora"
  description = "allow mysql port from all"

  tags = {
    Name = "${var.namespace}-sg-allowaurora"
    migrationteam = var.namespace
  }
}

resource "aws_security_group_rule" "sgr_ingress_allowaurora" {
  type = "ingress"
  security_group_id = aws_security_group.sg_allowaurora.id
  
  from_port   = 3306
  to_port     = 3306 
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "allow all internal communications to mysql port"
}

resource "aws_security_group_rule" "sgr_egress_allowaurora" {
  type = "egress"
  security_group_id = aws_security_group.sg_allowaurora.id
  
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
/*}}}*/

# security group allow mysql from sg_allowaurora{{{
resource "aws_security_group" "sg_allowmysql_from_sg_allowaurora" {
  vpc_id      = var.vpc
  name        = "${var.namespace}-sg-allowmysql-from-sg-allowaurora"
  description = "allow mysql port from sg-allowaurora"

  tags = {
    Name = "${var.namespace}-sg-allowmysql-from-sg-allowaurora"
    migrationteam = var.namespace
  }
}

resource "aws_security_group_rule" "sgr_ingress_allowmysql_from_sg_allowaurora" {
  type = "ingress"
  security_group_id = aws_security_group.sg_allowmysql_from_sg_allowaurora.id
 
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  source_security_group_id = aws_security_group.sg_allowaurora.id
}

resource "aws_security_group_rule" "sgr_egress_allowmysql_from_sg_allowaurora" {
  type = "egress"
  security_group_id = aws_security_group.sg_allowmysql_from_sg_allowaurora.id
 
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
/*}}}*/

