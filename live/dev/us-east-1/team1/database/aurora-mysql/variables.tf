variable "namespace" {
  description = "The project namespace to use for unique resource naming"
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

variable "instance_count" {
  description = "instance_count, including writer and replicas"
  type        = string
}
