# data "aws_subnet" "db_subnet" {
#   id = var.database_subnets_ids[0]
# }


data "aws_caller_identity" "current" {}


# data "aws_db_instance" "db" {
#   db_instance_identifier = var.identifier
# }

# data "aws_db_subnet_group" "subnet_group" {
#   name = data.aws_db_instance.db.db_subnet_group
# } 

# output "subnet_ids" {
#   value = data.aws_db_subnet_group.subnet_group.subnet_ids
# }

# BACKUP VAULT 
data "aws_iam_policy_document" "backup_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "backup:DescribeBackupVault",
      "backup:DeleteBackupVault",
      "backup:PutBackupVaultAccessPolicy",
      "backup:DeleteBackupVaultAccessPolicy",
      "backup:GetBackupVaultAccessPolicy",
      "backup:StartBackupJob",
      "backup:GetBackupVaultNotifications",
      "backup:PutBackupVaultNotifications",
    ]

    resources = [aws_backup_vault.vault_name.arn]
  }
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}