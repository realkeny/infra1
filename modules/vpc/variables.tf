variable "environ" {
  type        = string
  description = "infrastructure environment"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
}

variable "av_zones" {
  type = list(string)
  description = "AZs to create subnets into"
}

variable "public_subnets" {
  type = list(string)
  description = "subnets to create for public network traffic, one per AZ"
}

variable "private_subnets" {
  type = list(string)
  description = "subnets to create for private network traffic, one per AZ"
}

#variable "database_subnets" {
#  type = list(string)
#  description = "subnets to create for database traffic, one per AZ"
#}
