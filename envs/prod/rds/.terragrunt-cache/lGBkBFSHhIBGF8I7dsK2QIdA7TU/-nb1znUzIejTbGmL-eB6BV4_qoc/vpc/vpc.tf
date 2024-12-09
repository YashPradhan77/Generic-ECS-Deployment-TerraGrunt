module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"
  name    = "${local.namespace}_VPC_${local.environment}"
  cidr    = local.vpc_cidr_block

  azs              = local.azs
  private_subnets  = local.private_subnets
  public_subnets   = local.public_subnets
  database_subnets = local.database_subnets


  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  # tags = merge({
  #   Name = "${var.namespace}_VPC_${var.environment}"
  # }, var.common_tags)
}

