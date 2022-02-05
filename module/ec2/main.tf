module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  # insert the 10 required variables here
  name = "cloudcasts-${var.infra_env}"
  count = var.instance_count
  ami                    = var.instance_ami
  instance_type          = var.instance_size
  vpc_security_group_ids = var.security_groups
  subnet_id = subnets[count.index]

  root_block_device = [{
    volume_size = var.instance_root_device_size
    volume_type = "gp3"
  }]

  tags = merge(
  {
    Name        = "ktech-${var.infra_env}"
    Role        = var.infra_role    
    Environment = var.environ
    ManagedBy   = "terraform"
  },
  var.tags
  )
}

