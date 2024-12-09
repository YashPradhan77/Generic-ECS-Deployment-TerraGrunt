# module "vpc_endpoints" {
#   source = "../../modules/vpc-endpoints"

#   vpc_id = var.vpc_id

#   create_security_group      = true
#   security_group_name_prefix = "${local.name}-vpc-endpoints-"
#   security_group_description = "VPC endpoint security group"

#   security_group_rules = {
#     ingress_https = {
#       description = "Allow HTTPS traffic for Secrets Manager"
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = [var.vpc_cidr_block]
#     }
#   }

#   endpoints = {
#     secretsmanager = {
#       service             = "secretsmanager"
#       service_type        = "Interface"
#       subnets             = var.private_subnet_ids
#       private_dns_enabled = true
#       tags                = { Name = "secretsmanager-vpc-endpoint" }
#     }
#   }
# }



