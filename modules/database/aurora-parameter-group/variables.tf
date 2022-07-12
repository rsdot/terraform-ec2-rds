variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "aurora_family" {
  description = "used for cluster and db parameter group"
  type        = string
}

variable "parameter_group_cluster" {
  description = "for cluster parameter_group"
  type = list(map(string))
}

variable "parameter_group_db" {
  description = "for db parameter_group"
  type = list(map(string))
}

