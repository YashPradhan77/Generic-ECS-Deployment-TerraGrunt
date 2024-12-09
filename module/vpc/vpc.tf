module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"
  name    = "${var.namespace}_VPC_${var.environment}"
  cidr    = var.vpc_cidr_block

  azs              = var.azs
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets


  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = merge({
    Name = "${var.namespace}_VPC_${var.environment}"
  }, var.common_tags)
}

