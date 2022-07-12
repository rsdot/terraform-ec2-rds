variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "key_name" {
  description = "The name for ssh into the jumphost"
  type        = string
  default     = "jumphost"
}

variable "instance_type" {
  description = "The name for jumphost type"
  type        = string
  default     = "t2.micro"
}

