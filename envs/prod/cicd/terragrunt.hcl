# terraform {
#   source = "../../../module//cicd_aws_role"
# }


# include "root" {
#   path = find_in_parent_folders()
# }

# dependencies {
#   paths = ["../vpc", "../ecs", "../rds"]
# }

# inputs = {
#     # CICD Settings
#     oidc_provider_url = "https://token.actions.githubusercontent.com"
# }