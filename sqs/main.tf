terraform {
  required_version = ">= 0.12"

  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/dl/sqs_matillion"
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  environment = terraform.workspace
}


resource "aws_sqs_queue" "q" {
  name = "DataLake_ETL_Launchpad_Snowflake"
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = "https://sqs.us-west-2.amazonaws.com/${var.environment_values[local.environment]["account_id"]}/${aws_sqs_queue.q.name}"
  policy ="${file("${var.environment_values[local.environment]["sqs_json_file"]}")}"
 }

