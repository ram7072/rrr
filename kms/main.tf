terraform {
  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/ec2_kms_terraform_state" #purpose
  }
}

provider "aws" {
  region = var.provider_region
}

locals {
  environment = terraform.workspace
}

resource "aws_kms_alias" "alias" {
  name          = "alias/s3-alias"
    target_key_id = "9dfda44f-b7cf-4608-8aee-31eabdd9274c"
    }
