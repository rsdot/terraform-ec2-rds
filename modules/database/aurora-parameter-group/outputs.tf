output "rds_cpg_name" {
  value = aws_rds_cluster_parameter_group.rds_cpg.name
}

output "rds_pg_name" {
  value = aws_db_parameter_group.rds_pg.name
}

