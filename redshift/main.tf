terraform {
  required_version = ">= 0.12"

  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/redshift_terraform_state"
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  environment = terraform.workspace
}

resource "aws_iam_service_linked_role" "AWSServiceRoleForRedshift" {
  aws_service_name = "redshift.amazonaws.com"
}

/*resource "aws_iam_role" "dsm-datalake-redshift" {
  name = "dsm-datalake-redshift"

  assume_role_policy = "${file("dsm-datalake-redshiftPolicyDocument.json")}"
  tags = {
    Name = "dsm-datalake-redshift"
  }
}*/

resource "aws_redshift_cluster" "redshift_resource" {
  cluster_identifier        = var.environment_values[local.environment]["cluster_identifier"]
  database_name             = var.environment_values[local.environment]["database_name"]
  port                      = var.environment_values[local.environment]["port"]
  master_username           = var.environment_values[local.environment]["master_username"]
  master_password           = var.environment_values[local.environment]["master_password"]
  node_type                 = var.environment_values[local.environment]["node_type"]
  number_of_nodes           = var.environment_values[local.environment]["number_of_nodes"]
  #cluster_type              = "${var.environment_values[local.environment]["number_of_nodes"]} > 1 ? 'multi-node' : 'single-node'"
  cluster_type              = "multi-node"
  iam_roles                 = [aws_iam_service_linked_role.AWSServiceRoleForRedshift.arn]
  publicly_accessible       = var.environment_values[local.environment]["publicly_accessible"]
  skip_final_snapshot       = var.environment_values[local.environment]["skip_final_snapshot"]
  encrypted                 = var.environment_values[local.environment]["encrypted"]
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_resource.name
  vpc_security_group_ids    = [aws_security_group.redshift_sg.id]
}

resource "aws_redshift_subnet_group" "redshift_subnet_resource" {
  name       = var.environment_values[local.environment]["redshift_subnet_grp_name"]
  subnet_ids = var.environment_values[local.environment]["subnets"]
}

resource "aws_security_group" "redshift_sg" {
  ingress {
    cidr_blocks = var.environment_values[local.environment]["whitelist_cidr_blocks"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    self        = false
  }
  ingress {
    cidr_blocks = var.environment_values[local.environment]["whitelist_cidr_blocks"]
    from_port   = var.environment_values[local.environment]["from_port"] #5439
    protocol    = var.environment_values[local.environment]["protocol"]  #tcp
    to_port     = var.environment_values[local.environment]["to_port"]   #5439
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.environment_values[local.environment]["whitelist_cidr_blocks"]
  }
  name   = var.environment_values[local.environment]["redshift_sg_name"]
  vpc_id = var.environment_values[local.environment]["vpc_id"]
}

