terraform {
  source = "../../../module//cicd_aws_role"
}


include "root" {
  path = find_in_parent_folders()
}

inputs = {
    # CICD Settings
    oidc_provider_url = "https://token.actions.githubusercontent.com"
}