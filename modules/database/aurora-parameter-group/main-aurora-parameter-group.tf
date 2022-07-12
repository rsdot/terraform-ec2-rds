locals {
  suffix = replace(var.aurora_family,".","-")
}

resource "aws_rds_cluster_parameter_group" "rds_cpg" {
  name   = "${var.namespace}-rds-cpg-${local.suffix}"
  family = var.aurora_family

  dynamic "parameter" {
    for_each = var.parameter_group_cluster 

    content { 
      name         = parameter.value.name 
      value        = parameter.value.value 
      apply_method = lookup(parameter.value, "apply_method", null) 
    } 
  }

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_db_parameter_group" "rds_pg" {
  name   = "${var.namespace}-rds-pg-${local.suffix}"
  family = var.aurora_family

  dynamic "parameter" {
    for_each = var.parameter_group_db 

    content { 
      name         = parameter.value.name 
      value        = parameter.value.value 
      apply_method = lookup(parameter.value, "apply_method", null) 
    } 
  }

  tags = {
    migrationteam = var.namespace
  }
}

