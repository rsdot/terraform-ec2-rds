variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "engine_version" {
  description = "used for cluster setup"
  type        = string
}

variable "cluster_identifier" {
  description = "aurora cluser identifier"
  type        = string
}

variable "instance_identifier_prefix" {
  description = "aurora instance identifier prefix"
  type        = string
}

variable "db_subnet_group_name" {
  description = "db_subnet_group_name"
  type        = string
}

# sensitive won't log the values when you run plan or apply
# shouldn't use default, you can set TF_VAR_master_username & TF_VAR_master_password system variable instead

variable "master_username" {
  description = "The name for master user"
  type        = string
  sensitive   = true
}

variable "master_password" {
  description = "The name for master password"
  type        = string
  sensitive   = true
}

variable "db_cluster_parameter_group_name" {
  description = "for cluster parameter group"
  type        = string
}

variable "db_parameter_group_name" {
  description = "for db parameter group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "for aurora security group ids"
  type        = list(string)
}

variable "enabled_cloudwatch_logs_exports" {
  type = list(string)
  default = ["audit","error","general","slowquery"]
}

variable "engine" {
  description = "engine"
  type        = string
  default     = "aurora-mysql"
}

variable "availability_zones" {
  description = "availability_zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance_class" {
  description = "instance_class"
  type        = string
  default     = "db.r6g.large"
}

variable "instance_count" {
  description = "instance_count, including writer and replicas"
  type        = string
  default     = 2
}

variable "backup_retention_period" {
  description = "backup_retention_period"
  type        = string
  default     = 1
}

variable "preferred_backup_window" {
  description = "preferred_backup_window"
  type        = string
  default     = "06:00-12:00"
}

variable "performance_insights_enabled" {
  description = "performance_insights_enabled"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "performance_insights_retention_period"
  type        = number
  default     = 7
}

