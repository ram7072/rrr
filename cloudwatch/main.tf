terraform {
  required_version = ">= 0.12"

  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/cloudwatch_monthly_schedule"
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  environment = terraform.workspace
}

resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = "DL_MTLN_SQS_MASTER_MONTHLY"
  description = "To trigger the matillion master monthly jobs on 1st Sunday of every month - 10 PM PST"
  schedule_expression = "cron(0 6 ? * 2#1 *)"
  }
  
 
resource "aws_cloudwatch_event_target" "sqs" {
  rule       = "${aws_cloudwatch_event_rule.cloudwatch_event_rule.name}"
  target_id        = "DataLake_ETL_Launchpad_Snowflake"
  arn           = "arn:aws:sqs:us-west-2:${var.environment_values[local.environment]["account_id"]}:DataLake_ETL_Launchpad_Snowflake"
  input ="${file("${var.environment_values[local.environment]["cloudwatch_json_file"]}")}"
 }

resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = "https://sqs.us-west-2.amazonaws.com/${var.environment_values[local.environment]["account_id"]}/DataLake_ETL_Launchpad_Snowflake"
  policy ="${file("${var.environment_values[local.environment]["sqs_json_file"]}")}"
 }
  
