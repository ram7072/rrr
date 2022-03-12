#############################################################################
#Terraform module to create Postgres RDS cluster and databases needed for the
#Data Lake Project
#############################################################################

terraform {


  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/rds_terraform_state"
  }
}

locals {
  environment = terraform.workspace
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment_values[local.environment]["project"]}-${var.environment_values[local.environment]["subnet_group"]}-${var.environment_values[local.environment]["environment"]}"
  subnet_ids = var.environment_values[local.environment]["subnet_ids"]

  tags = {
    Name        = "${var.environment_values[local.environment]["subnet_group"]}-${var.environment_values[local.environment]["environment"]}"
    Project     = var.environment_values[local.environment]["project"]
    Environment = var.environment_values[local.environment]["environment"]
  }
}

#
# Security group resources
#
resource "aws_security_group" "postgresql" {
  vpc_id = var.environment_values[local.environment]["vpc_id"]

  tags = {
    Name        = "${var.environment_values[local.environment]["project"]}-postgres-sg-${var.environment_values[local.environment]["environment"]}" 
    Project     = var.environment_values[local.environment]["project"]
    Environment = var.environment_values[local.environment]["environment"]
  }
}

#
#security group rules
#
resource "aws_security_group_rule" "ssh_allow_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

resource "aws_security_group_rule" "postgres_access_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 5432
  to_port           = 5432
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

resource "aws_security_group_rule" "https_access_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

#outbound
resource "aws_security_group_rule" "ssh_allow_outbound" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

resource "aws_security_group_rule" "postgres_access_outbound" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 5432
  to_port           = 5432
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

resource "aws_security_group_rule" "https_access_outbound" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgresql.id
}

#
#database resources
#
resource "aws_db_instance" "postgresql_cmb" {
  allocated_storage          = var.environment_values[local.environment]["cmb_allocated_storage"]
  engine                     = var.environment_values[local.environment]["database_engine"]
  engine_version             = var.engine_version
  identifier                 = "${var.environment_values[local.environment]["project"]}-${var.environment_values[local.environment]["cmb_database_identifier"]}-${var.environment_values[local.environment]["environment"]}"
  instance_class             = var.environment_values[local.environment]["cmb_instance_type"]
  storage_type               = var.storage_type
  iops                       = var.iops
  name                       = var.environment_values[local.environment]["cmb_database_name"]
  password                   = var.environment_values[local.environment]["database_password"]
  username                   = var.environment_values[local.environment]["database_username"]
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.environment_values[local.environment]["backup_window"]
  maintenance_window         = var.environment_values[local.environment]["maintenance_window"]
  auto_minor_version_upgrade = var.environment_values[local.environment]["auto_minor_version_upgrade"]
  performance_insights_enabled = var.environment_values[local.environment]["performance_insights_enabled"]
  skip_final_snapshot        = var.skip_final_snapshot
  copy_tags_to_snapshot      = var.copy_tags_to_snapshot
  multi_az                   = var.multi_availability_zone
  port                       = var.environment_values[local.environment]["database_port"]
  vpc_security_group_ids     = [aws_security_group.postgresql.id]
  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
  storage_encrypted          = var.storage_encrypted
  tags = {
    Name        = "DatabaseServer"
    Project     = var.environment_values[local.environment]["project"]
    Environment = var.environment_values[local.environment]["environment"]
  }
}

resource "aws_db_instance" "postgresql_mdm" {
  allocated_storage          = var.environment_values[local.environment]["mdm_allocated_storage"]
  engine                     = var.environment_values[local.environment]["database_engine"]
  engine_version             = var.engine_version
  identifier                 = "${var.environment_values[local.environment]["project"]}-${var.environment_values[local.environment]["mdm_database_identifier"]}-${var.environment_values[local.environment]["environment"]}"
  instance_class             = var.environment_values[local.environment]["mdm_instance_type"]
  storage_type               = var.storage_type
  iops                       = var.iops
  name                       = var.environment_values[local.environment]["mdm_database_name"]
  password                   = var.environment_values[local.environment]["database_password"]
  username                   = var.environment_values[local.environment]["database_username"]
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.environment_values[local.environment]["backup_window"]
  maintenance_window         = var.environment_values[local.environment]["maintenance_window"]
  auto_minor_version_upgrade = var.environment_values[local.environment]["auto_minor_version_upgrade"]
  performance_insights_enabled = var.environment_values[local.environment]["performance_insights_enabled"]
  skip_final_snapshot        = var.skip_final_snapshot
  copy_tags_to_snapshot      = var.copy_tags_to_snapshot
  multi_az                   = var.multi_availability_zone
  port                       = var.environment_values[local.environment]["database_port"]
  vpc_security_group_ids     = [aws_security_group.postgresql.id]
  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
  storage_encrypted          = var.storage_encrypted
  tags = {
    Name        = "DatabaseServer"
    Project     = var.environment_values[local.environment]["project"]
    Environment = var.environment_values[local.environment]["environment"]
  }
}

