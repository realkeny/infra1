variable "aws_secret" {
  type = string
  description = "aws secret key"
  sensitive = true
}
variable "aws_key" {
  type = string
  description = "aws access id"
  sensitive = true
}

variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "aws region to use for resources"
}

variable "environ" {
  type        = string
  description = "infrastructure environment"
  default     = "production"
}

variable "vpc_cidr" {
  type = string
  description = "vpc cidr range"
  default = "10.1.10.0/24"
}

variable "database_subnet_group_name" {
  type = string
  default = "test"  
}