output "vpc" {
  value = module.vpc.vpc
}

output "sb_public" {
  value = module.subnet.sb_public
}

output "sb_private" {
  value = module.subnet.sb_private
}

output "sb_aurora" {
  value = module.subnet.sb_aurora
}

output "sg_allowssh" {
  value = module.security_group.sg_allowssh
}

output "sg_allowaurora" {
  value = module.security_group.sg_allowaurora
}

output "sg_allowmysql_from_sg_allowaurora" {
  value = module.security_group.sg_allowmysql_from_sg_allowaurora
}

