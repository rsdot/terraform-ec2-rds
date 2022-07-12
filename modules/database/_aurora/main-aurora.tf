resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier              = var.cluster_identifier
  engine                          = var.engine
  availability_zones              = var.availability_zones
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = var.backup_retention_period 
  preferred_backup_window         = var.preferred_backup_window
  db_subnet_group_name            = var.db_subnet_group_name
  engine_version                  = var.engine_version
  storage_encrypted               = true
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  apply_immediately               = true
  vpc_security_group_ids          = var.vpc_security_group_ids
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  lifecycle {
    ignore_changes = [global_cluster_identifier]
  }

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_rds_cluster_instance" "aurora_instance_writer" {
  identifier                            = "${var.instance_identifier_prefix}-0"
  cluster_identifier                    = aws_rds_cluster.aurora_cluster.id
  instance_class                        = var.instance_class
  engine                                = var.engine
  db_parameter_group_name               = var.db_parameter_group_name
  auto_minor_version_upgrade            = false
  promotion_tier                        = 0
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  apply_immediately                     = true

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_rds_cluster_instance" "aurora_instance_replicas" {
  count                                 = var.instance_count - 1

  identifier                            = "${var.instance_identifier_prefix}-${count.index + 1}"
  cluster_identifier                    = aws_rds_cluster.aurora_cluster.id
  instance_class                        = var.instance_class
  engine                                = var.engine
  db_parameter_group_name               = var.db_parameter_group_name
  auto_minor_version_upgrade            = false
  promotion_tier                        = count.index
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  apply_immediately                     = true

  tags = {
    migrationteam = var.namespace
  }

  depends_on = [
     aws_rds_cluster_instance.aurora_instance_writer 
  ]
}

