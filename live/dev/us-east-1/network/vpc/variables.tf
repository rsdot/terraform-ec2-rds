variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The cidr_block for vpc"
  type        = string
}
