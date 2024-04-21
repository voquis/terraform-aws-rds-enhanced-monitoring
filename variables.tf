# ---------------------------------------------------------------------------------------------------------------------
# Required variables
# ---------------------------------------------------------------------------------------------------------------------
variable "subnet_ids" {
  description = "Subnet ids for DB subnet group"
  type        = list(string)
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# ---------------------------------------------------------------------------------------------------------------------
variable "db_subnet_group_name" {
  description = "Optional name of DB Subnet group."
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "GB of storage to allocate to each RDS instance"
  type        = number
  default     = 10
}

variable "apply_immediately" {
  description = "Whether to wait for maintenance window or apply changes immediately"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to keep backup snapshots"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Time of day to perform backups"
  type        = string
  default     = "01:00-02:00"
}

variable "copy_tags_to_snapshot" {
  description = "Whether or not to copy tags to snapshots"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether or not to prevent deletion"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "iam_database_authentication_enabled" {
  description = "Whether to use IAM authentication"
  type        = bool
  default     = null
}

variable "identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t2.small"
}

variable "max_allocated_storage" {
  description = "The maximum amount of storage to allow with storage autoscaling"
  type        = number
  default     = null
}

variable "multi_az" {
  description = "Whether multiple AZs should be used for redundency"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether a final backup snapshot should be skipped on deletion"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Whether storage is encrypted, not applicable to t2.micro instance classes"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "maintenance_window" {
  description = "Maintenance window for auto minor update and snapshots"
  type        = string
  default     = "Sat:03:00-Sat:04:00"
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval"
  type        = number
  default     = 60
}

variable "parameter_group_name" {
  description = "Parameter group name"
  type        = string
  default     = "default.mysql8.0"
}

variable "password" {
  description = "Master password"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "KMS key ARN to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "Number of days to retain performance insights"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Whether instance is publically accessible"
  type        = bool
  default     = false
}

variable "username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

variable "vpc_security_group_ids" {
  description = "VPC security group ids"
  type        = list(string)
  default     = null
}

variable "role_name" {
  type        = string
  description = "Role name for enhanced monitoring"
  default     = null
}

variable "db_name" {
  type        = string
  description = "Initial database name"
  default     = null
}

variable "availability_zone" {
  type        = string
  description = "Preferred availability zone"
  default     = null
}

variable "manage_master_user_password" {
  type        = string
  description = "Whether secrets manager should be used to manage the master password"
  default     = null
}
