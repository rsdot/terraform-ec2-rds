namespace = "rsdot-team1"

aurora_family = "aurora-mysql5.7"

# aws rds describe-db-cluster-parameters --db-cluster-parameter-group-name xxx-rds-cpg-aurora-mysql5-7 --query '*[?IsModifiable==`false`]' | C
# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Replication.CrossRegion.html

parameter_group_cluster = [
  {
    name         = "performance_schema"
    value        = "1"
    apply_method = "pending-reboot"
  },
  {
    name         = "slow_query_log"
    value        = "1"
    apply_method = "immediate"
  },
  # {
  #   name         = "log_output"
  #   value        = "FILE"
  #   apply_method = "pending-reboot"
  # },
  {
    name         = "long_query_time"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "min_examined_row_limit"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "innodb_print_all_deadlocks"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "aws_default_s3_role"
    value        = "arn:aws:iam::019101706342:role/aurora_access_s3_role"
    apply_method = "pending-reboot"
  },
  {
    name         = "event_scheduler"
    value        = "ON"
    apply_method = "immediate"
  },
  {
    name         = "binlog_format"
    value        = "MIXED"
    apply_method = "pending-reboot"
  }
]

# aws rds describe-db-parameters --db-parameter-group-name xxx-rds-pg-aurora-mysql5-7

parameter_group_db = [
  {
    name         = "performance_schema"
    value        = "1"
    apply_method = "pending-reboot"
  },
  {
    name         = "slow_query_log"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "log_output"
    value        = "FILE"
    apply_method = "pending-reboot"
  },
  {
    name         = "long_query_time"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "min_examined_row_limit"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "innodb_print_all_deadlocks"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "event_scheduler"
    value        = "ON"
    apply_method = "immediate"
  }
]

