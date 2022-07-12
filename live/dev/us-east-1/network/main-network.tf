module "vpc" {
  source = "./vpc"

  namespace      = var.namespace
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnet" {
  source = "./subnet"

  namespace             = var.namespace
  vpc                   = module.vpc.vpc
  sb_public_cidr_block  = var.sb_public_cidr_block
  sb_private_cidr_block = var.sb_private_cidr_block
}

module "security_group" {
  source = "./security-group"

  namespace = var.namespace
  vpc = module.vpc.vpc
}

