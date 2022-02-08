terraform{
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
    cidr_subnets = cidrsubnets(var.vpc_cidr, 3,3,3,3)
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = var.vpc_cidr
  environ = var.environ  
  av_zones = slice(data.aws_availability_zones.available.names,0,2)
  public_subnets = slice(local.cidr_subnets, 0, 2)
  private_subnets = slice(local.cidr_subnets, 2, 4)
  #database_subnets = slice(local.cidr_subnets, 5, 7)
}