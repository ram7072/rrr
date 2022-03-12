terraform {
  required_version = ">= 0.12"

  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/ert/lambda/datalake_extract_census"
  }
}

provider "aws" {
  region = "us-west-2"
  
  


}

locals {
  environment = terraform.workspace
}
resource "aws_cloudwatch_event_rule" "every_year_jan20" {
    name = "DL_MTLN_SQS_YEAR_CW_SCHEDULE"
    description = "Every year scheduling the job for loading the census data to the snowflake"
    #schedule_expression = "cron(0 0 20 1 ? *)"
	schedule_expression = "cron(* */1 11 12 ? *)"
	
}
#cron(Minutes Hours Day-of-month Month Day-of-week Year)



resource "aws_cloudwatch_event_target" "sqs_yrly_bat_micro" {
  rule       = aws_cloudwatch_event_rule.every_year_jan20.name
  target_id  = "DataLake_ETL_Launchpad_Snowflake"
  arn        = "arn:aws:sqs:us-west-2:${var.environment_values[local.environment]["account_id"]}:DataLake_ETL_Launchpad_Snowflake"
  input = <<INPUT
{
"group":"${var.environment_values[local.environment]["group"]}", "project":"SNOWFLAKE_DATALAKE", "version":"default", "environment":"${var.environment_values[local.environment]["environment_id"]}", "job":"orch_bat_master_yearly"}
INPUT
}







resource "aws_iam_role" "Census1_Load_profile_lambda_role"{
  name = "Census1_Load_profile_lambda_role"
  description = "Allows Load profile lambda  to load census data to snowflake table."  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach0" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach1" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach2" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach3" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach4" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  
}
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach5" {
  role       = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = var.environment_values[local.environment]["kms_policy"]
  
  
  }

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach6" {
  role      = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


resource "aws_iam_role_policy_attachment" "lambda_role_policy_attach7" {
  role      = aws_iam_role.Census1_Load_profile_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  }
#tags = {
    #Environment         = var.environment_values[local.environment]["environment"]
    #"Application Name"  = var.environment_values[local.environment]["application_name"]
    #Confidentiality     = var.environment_values[local.environment]["confidentiality"]
    #"Cost Center"       = var.environment_values[local.environment]["cost_center"]
    #"DCIO"              = var.environment_values[local.environment]["dcio"]
    #"Name"              = "Census Account Programmatic Access"
    #"Owner"             = var.environment_values[local.environment]["owner"]
    #"Project"           = var.environment_values[local.environment]["project"]
    #}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "lambda_census_layer.zip"
  layer_name = "Census_3_6"

  compatible_runtimes = ["python3.6"]
}



resource "aws_lambda_function" "lambda2" {
  filename      = var.environment_values[local.environment]["payload"]
  function_name = "datalake_extract_census"
  role= aws_iam_role.Census1_Load_profile_lambda_role.arn
  #role          =  var.environment_values[local.environment]["lambda_role"]
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  handler       = "lambda_function.lambda_handler"
  
tags = {
    Environment         = var.environment_values[local.environment]["environment"]
    "Application Name"  = var.environment_values[local.environment]["application_name"]
    Confidentiality     = var.environment_values[local.environment]["confidentiality"]
    "Cost Center"       = var.environment_values[local.environment]["cost_center"]
    "DCIO"              = var.environment_values[local.environment]["dcio"]
    "Name"              = "Census Account Programmatic Access"
    "Owner"             = var.environment_values[local.environment]["owner"]
    "Project"           = var.environment_values[local.environment]["project"]
    }
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.environment_values[local.environment]["payload"])

  runtime = var.environment_values[local.environment]["runtime"]
  timeout =  var.environment_values[local.environment]["lambda_timeout"]
 
  }


