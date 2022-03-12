terraform {
  required_version = ">= 0.12"

  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/adms_s3_terraform_state"
  }
}

locals {
  environment = terraform.workspace
}

provider "aws" {
  region = var.provider_region
}


resource "aws_s3_bucket_object" "folder_weather_input" {
  bucket = var.environment_values[local.environment]["bucket_name"]
  key    = "Datalake_Raw/Weather/Input/"
  acl = "private"
  content = "null"
    tags = {
    Environment = var.environment_values[local.environment]["environment"]
    "Application Name" = var.environment_values[local.environment]["application_name"]
    Confidentiality = var.environment_values[local.environment]["confidentiality"]
    "Cost Center" = var.environment_values[local.environment]["cost_center"]
    "DCIO" = var.environment_values[local.environment]["dcio"]
    "Name" = "S3_Weather_Input_folder"
    "Owner" = var.environment_values[local.environment]["owner"]
    "Project" = var.environment_values[local.environment]["project"]
   }
}

resource "aws_s3_bucket_object" "folder_weather_history" {
  bucket = var.environment_values[local.environment]["bucket_name"]
  key    = "Datalake_Raw/Weather/Input/History/"
  acl = "private"
  content = "null"
    tags = {
    Environment = var.environment_values[local.environment]["environment"]
    "Application Name" = var.environment_values[local.environment]["application_name"]
    Confidentiality = var.environment_values[local.environment]["confidentiality"]
    "Cost Center" = var.environment_values[local.environment]["cost_center"]
    "DCIO" = var.environment_values[local.environment]["dcio"]
    "Name" = "S3_Weather_History_Folder"
    "Owner" = var.environment_values[local.environment]["owner"]
    "Project" = var.environment_values[local.environment]["project"]
   }
}

resource "aws_s3_bucket_object" "folder_avl_input" {
  bucket = var.environment_values[local.environment]["bucket_name"]
  key    = "Datalake_Raw/AVL/"
  acl = "private"
  content = "null"
    tags = {
    Environment = var.environment_values[local.environment]["environment"]
    "Application Name" = var.environment_values[local.environment]["application_name"]
    Confidentiality = var.environment_values[local.environment]["confidentiality"]
    "Cost Center" = var.environment_values[local.environment]["cost_center"]
    "DCIO" = var.environment_values[local.environment]["dcio"]
    "Name" = "S3_AVL_Folder"
    "Owner" = var.environment_values[local.environment]["owner"]
    "Project" = var.environment_values[local.environment]["project"]
   }
}
