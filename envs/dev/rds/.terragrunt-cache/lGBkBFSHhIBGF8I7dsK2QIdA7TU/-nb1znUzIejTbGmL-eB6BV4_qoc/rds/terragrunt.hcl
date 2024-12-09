terraform {
  source = "../../../module//rds"
}


include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  # RDS settings
  identifier                          = "db-instance"
  engine                              = "postgres"
  engine_version                      = "13.3"
  instance_class                      = "db.t3.medium"
  allocated_storage                   = 20
  db_name                             = "appdb"
  username                            = "admin"
  port                                = 5432
  iam_database_authentication_enabled = true
  create_monitoring_role              = true
  create_db_subnet_group              = true
  family                              = "postgres13"
  major_engine_version                = "13"
  deletion_protection                 = false

  vpc_id               = dependency.vpc.outputs.vpc_id
  database_subnets_ids = dependency.vpc.outputs.database_subnets

  # Backup vault settings
  backup_vault_name             = "rds-backup-vault"
  backup_service_selection_name = "rds-backup-selection"
  bp_name                       = "rds-backup-policy"
  bp_rule_name                  = "rds-backup-rule"
  bp_rule_schedule              = "cron(0 12 * * ? *)"
  delete_after                  = 30
  schedule_expression_timezone  = "Asia/Singapore"
  start_window                  = 60
  completion_window             = 120
}

