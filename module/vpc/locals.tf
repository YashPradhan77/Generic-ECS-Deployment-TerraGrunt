# Define individual local variables to hold values for easy reference
locals {
  config = yamldecode(file("variables.yml"))

  namespace   = local.config["namespace"]
  environment = local.config["environment"]
  region      = local.config["region"]

  # VPC
  vpc_config       = local.config["vpc"]
  vpc_cidr_block   = local.vpc_config["vpc_cidr_block"]
  azs              = local.vpc_config["azs"]
  public_subnets   = local.vpc_config["public_subnets"]
  private_subnets  = local.vpc_config["private_subnets"]
  database_subnets = local.vpc_config["database_subnets"]

  # Tags
  common_tags = local.config["common_tags"]
}
