variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The cidr_block for vpc"
  type        = string
}

variable "sb_public_cidr_block" {
  description = "The cidr_block for public subnet"
  type        = string
}

variable "sb_private_cidr_block" {
  description = "The cidr_block for private subnet database aurora across AZ"
  type        = map(string)
}

