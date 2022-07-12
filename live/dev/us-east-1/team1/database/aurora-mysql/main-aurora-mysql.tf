# aws rds describe-db-engine-versions --query "DBEngineVersions[].EngineVersion"

module "aurora" {
  source = "../../../../../../modules/database/dev-aurora-mysql"

  namespace                       = var.namespace
  master_username                 = var.master_username
  master_password                 = var.master_password
  engine_version                  = var.engine_version
  cluster_identifier              = var.cluster_identifier
  instance_identifier_prefix      = var.instance_identifier_prefix
  db_subnet_group_name            = var.db_subnet_group_name
  db_cluster_parameter_group_name = data.terraform_remote_state.aurora_mysql_parameter_group.outputs.rds_cpg_name
  db_parameter_group_name         = data.terraform_remote_state.aurora_mysql_parameter_group.outputs.rds_pg_name
  vpc_security_group_ids          = [data.terraform_remote_state.network.outputs.sg_allowaurora]
  instance_count                  = var.instance_count
}

