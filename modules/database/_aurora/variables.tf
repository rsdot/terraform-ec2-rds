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
}

variable "engine" {
  description = "engine"
  type        = string
}

variable "availability_zones" {
  description = "availability_zones"
  type        = list(string)
}

variable "instance_class" {
  description = "instance_class"
  type        = string
}

variable "instance_count" {
  description = "instance_count, including writer and replicas"
  type        = string
}

variable "backup_retention_period" {
  description = "backup_retention_period"
  type        = string
}

variable "preferred_backup_window" {
  description = "preferred_backup_window"
  type        = string
}

variable "performance_insights_enabled" {
  description = "performance_insights_enabled"
  type        = bool
}

variable "performance_insights_retention_period" {
  description = "performance_insights_retention_period"
  type        = number
}

