terraform{
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_key
  secret_key = var.aws_secret
}

data "aws_ami" "linux2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "aws_vpc" "vpc" {
  tags = {
    Name        = "ktech-${var.environ}-vpc"    
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name        = "ktech-${var.environ}-vpc"    
    Environment = var.environ
    ManagedBy   = "terraform"
    Role        = "public"
  }
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name        = "ktech-${var.environ}-vpc"    
    Environment = var.environ
    ManagedBy   = "terraform"
    Role        = "private"
  }
}

data "aws_security_groups" "public_sg" {
  tags = {
    Name        = "ktech-${var.environ}-public-sg"
    Role        = "public"    
    Environment = var.environ
    ManagedBy   = "terraform"
  }
}

data "aws_security_groups" "private_sg" {
  tags = {
    Name        = "ktech-${var.environ}-private-sg"
    Role        = "private"    
    Environment = var.environ
    ManagedBy   = "terraform"
  }
}

module "ec2_app" {
  source = "../../modules/ec2"

  #name = "app1"
  environ = var.environ
  infra_role = "web"
  instance_size = "t2.micro"
  instance_ami = data.aws_ami.linux2.id
  # instance_root_device_size = 12
  subnets = data.aws_subnet_ids.public_subnets.ids
  security_groups = data.aws_security_groups.public_sg.ids
  tags = {
    Name = "ktech-${var.environ}-web"
  }
  create_eip = true
}

module "ec2_worker" {
  source = "../../modules/ec2"

  #name = "worker1"
  environ = var.environ
  infra_role = "worker"
  instance_size = "t2.micro"
  instance_ami = data.aws_ami.linux2.id
  instance_root_device_size = 20
  subnets = data.aws_subnet_ids.private_subnets.ids
  security_groups = data.aws_security_groups.private_sg.ids
  tags = {
    Name = "ktech-${var.environ}-worker"
  }
  
}