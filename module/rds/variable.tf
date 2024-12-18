
variable "namespace" {
  description = "Namespace for resource names"
  default     = "ecs"
  type        = string
}


variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "dev"
  type        = string
}



variable "database_subnets_ids" {
  description = "Provide database subnets in list"
  type        = list(string)
}

# The engine type for the RDS instance
variable "engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "mysql"
}

# The version of the database engine
variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "5.7"
}

# The instance class for the RDS instance
variable "instance_class" {
  description = "The instance class for the RDS database instance"
  type        = string
  default     = "db.t3a.large"
}

# The allocated storage (in GB) for the RDS instance
variable "allocated_storage" {
  description = "The allocated storage in GB for the RDS instance"
  type        = number
  default     = 5
}

# The database name
variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "demodb"
}

# The username for connecting to the database
variable "username" {
  description = "The username for the database"
  type        = string
  default     = "user"
}



# The port for the database instance
variable "port" {
  description = "The port on which the database listens"
  type        = string
  default     = "3306"
}

# Whether IAM database authentication is enabled
variable "iam_database_authentication_enabled" {
  description = "Whether IAM database authentication is enabled"
  type        = bool
  default     = true
}

# Whether to create a monitoring role for the RDS instance
variable "create_monitoring_role" {
  description = "Whether to create a monitoring role for the RDS instance"
  type        = bool
  default     = true
}

# Whether to create a DB subnet group
variable "create_db_subnet_group" {
  description = "Whether to create a DB subnet group"
  type        = bool
  default     = true
}

# The family of the DB parameter group
variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql5.7"
}

# The major version of the database engine for the DB option group
variable "major_engine_version" {
  description = "The major engine version for the DB option group"
  type        = string
  default     = "5.7"
}

# Whether to enable deletion protection for the RDS instance
variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the RDS instance"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The identifier for the RDS database instance"
  type        = string
  default     = "db-instance"
}


variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster will be deployed"
  type        = string
}
# BACKUP VAULT VARIABLES

variable "backup_vault_name" {
  description = "The name of the AWS Backup Vault to store backup data."
  type        = string
}

variable "backup_service_selection_name" {
  description = "The name for the backup service selection configuration."
  type        = string
}

variable "bp_name" {
  description = "The name of the backup plan."
  type        = string
}

variable "bp_rule_name" {
  description = "The name of the backup plan rule."
  type        = string
}

variable "bp_rule_schedule" {
  description = "The schedule for the backup plan rule in cron format."
  type        = string
}

variable "delete_after" {
  description = "The number of days after which the backup is automatically deleted."
  type        = number
}

variable "common_tags" {
  description = "A map of common tags to be applied to all resources"
  type        = map(string)
}

variable "schedule_expression_timezone" {}
variable "start_window" {}
variable "completion_window" {}