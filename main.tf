provider "aws" {
  region     = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  name_prefix         = terraform.workspace

  vpc_cidr            = "10.0.0.0/16"
  management_net_cidr = "10.0.30.0/24"
}

module "student_vm" {
  source           = "./modules/student-vm"
  name_prefix      = terraform.workspace

  aws_region       = var.aws_region
  key_pair         = var.key_pair
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.mgmt_subnet_id
  mgmt_private_ip  = "10.0.30.100"
}