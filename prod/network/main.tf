terraform{
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

variable "environ" {
  type        = string
  description = "infrastructure environment"
  default     = "production"
}

variable "vpc_cidr" {
  type = string
  description = "vpc cidr range"
  value = "10.1.10.0/24"
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
    cidr_subnets = cidrsubnets(var.vpc_cidr.value, 3,3,3,3,3,3,3)
}

module "vpc" {
  source = "../../modules/vpc"

  infra_env = var.infra_env
  vpc_cidr = "10.0.0.0/17"
  azs = slice(data.aws_availability_zones.available.names,0,2)
  public_subnets = slice(local.cidr_subnets, 0, 3)
  private_subnets = slice(local.cidr_subnets, 3, 5)
  database_subnets = slice(local.cidr_subnets, 5, 7)
}