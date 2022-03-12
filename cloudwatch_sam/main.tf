terraform {
  required_version = ">= 0.12"
  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/proactive_outage/cloudwatch/sam_extract"
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  environment = terraform.workspace
}

resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = "DL_MTLN_SAM_Daily_Load"
  description         = "To trigger the matillion proactive outage data load on daily basis at 2 AM PST or 5 AM UTC"
  schedule_expression = "cron(0 5 * * ? *)"
}
  
 
resource "aws_cloudwatch_event_target" "sqs" {
  rule       = "${aws_cloudwatch_event_rule.cloudwatch_event_rule.name}"
  target_id  = "DataLake_ETL_Launchpad_Snowflake"
  arn        = "arn:aws:sqs:us-west-2:${var.environment_values[local.environment]["account_id"]}:DataLake_ETL_Launchpad_Snowflake"
  input      = "${file("${var.environment_values[local.environment]["cloudwatch_json_file"]}")}"
 }
 
 
 