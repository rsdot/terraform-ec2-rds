# aws rds describe-db-engine-versions --query "DBEngineVersions[].DBParameterGroupFamily"

module "aurora_parameter_group" {
  source = "../../../../../../../modules/database/aurora-parameter-group"

  namespace               = var.namespace
  aurora_family           = var.aurora_family
  parameter_group_cluster = var.parameter_group_cluster
  parameter_group_db      = var.parameter_group_db
}

