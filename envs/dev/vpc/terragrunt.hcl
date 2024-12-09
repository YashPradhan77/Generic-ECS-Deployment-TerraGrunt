terraform {
  source = "../../../module//vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # General settings
  namespace   = "virtue"
  environment = "dev"
  region      = "ap-southeast-1"

  # VPC settings
  cidr_block       = "10.0.0.0/16"
  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  common_tags = {
    Terraform   = "true"
    Environment = "dev"
    Team        = "engineering"
    Project     = "my-project"
  }

}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOT
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}
EOT
}
