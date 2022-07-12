module "_aurora" {
  source = "../_aurora"

  namespace = var.namespace
  engine_version = var.engine_version
  cluster_identifier = var.cluster_identifier
  instance_identifier_prefix = var.instance_identifier_prefix
  db_subnet_group_name = var.db_subnet_group_name
  master_username = var.master_username
  master_password = var.master_password
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  db_parameter_group_name = var.db_parameter_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  engine = var.engine
  availability_zones = var.availability_zones
  instance_class = var.instance_class
  instance_count = var.instance_count
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
}

