module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.5"

  cidr = var.vpc_cidr

  azs = var.av_zones

  # Single NAT Gateway, see docs on terraform site
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  database_subnets = var.database_subnets

  tags = {
    Name = "ktech-${var.environ}-vpc"
    Environment = var.environ
    ManagedBy = "terraform"
  }

}
