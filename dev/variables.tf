variable "aws_secret" {
  type = string
  description = "aws secret key"  
}
variable "aws_key" {
  type = string
  description = "aws access id"  
}

variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "aws region to use for resources"
}

variable "env" {
  type = string
  description = "environment definition, e.g prod or dev"
  default = "Dev"
}

variable "public_key_path" {
  type = string
  description = "Public key path"
  default = "/home/kenny/.ssh/id_rsa.pub"
}

variable "instance_ami" {
  type = string
  description = "AMI for EC2 instance"
  default = "ami-0cf31d971a3ca20d6"
}

variable "instance_type" {
  type = string
  description = "type of EC2 instance to deploy"
  default = "t2.micro"
}

variable "instance_count" {
  type = number
  description = "number of ec2 instances to create"
  default = 2
}