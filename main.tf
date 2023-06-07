terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Subnet Group
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnet_ids
}

# ---------------------------------------------------------------------------------------------------------------------
# RDS instance
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/db_instance.html
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_instance" "this" {
  allocated_storage                   = var.allocated_storage
  apply_immediately                   = var.apply_immediately
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = aws_db_subnet_group.this.id
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  identifier                          = var.identifier
  instance_class                      = var.instance_class
  max_allocated_storage               = var.max_allocated_storage
  multi_az                            = var.multi_az
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = aws_iam_role.this.arn
  maintenance_window                  = var.maintenance_window
  password                            = var.password
  parameter_group_name                = var.parameter_group_name
  publicly_accessible                 = var.publicly_accessible
  username                            = var.username
  vpc_security_group_ids              = var.vpc_security_group_ids
  db_name                             = var.db_name
  availability_zone                   = var.availability_zone
  manage_master_user_password         = var.manage_master_user_password
}

# ---------------------------------------------------------------------------------------------------------------------
# # Policy document for role (and the service that can assume it) for Enhanced Monitoring
# Provider Docs: https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
# ---------------------------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create role to be be used for enhanced monitoring
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/iam_role.html
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

# ---------------------------------------------------------------------------------------------------------------------
# Attach AWS managed policy for enhanced monitoring to role
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
