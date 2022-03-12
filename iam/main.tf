terraform {
  backend "consul" {
      address = "consul.corp.dom:8500"
          path    = "aws/dl/ec2_iam_tf_state" #purpose
	    }
	    }
provider "aws" {
  region = var.provider_region
}


resource "aws_iam_role" "dms-vpc-role" {
  name = "dms-vpc-role1"

  assume_role_policy = "${file("dmsAssumeRolePolicyDocument.json")}"
  tags = {
    Name = "dms-vpc-role"
  }
}
resource "aws_iam_policy_attachment" "policy-role-attach" {
  name       = "dms-vpc-role-attachment"
  roles      = ["${aws_iam_role.dms-vpc-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
}

resource "aws_iam_role" "dms-cloudwatch-logs-role" {
  name = "dms-cloudwatch-logs-role"

  assume_role_policy = "${file("dmsAssumeRolePolicyDocument.json")}"
  tags = {
    Name = "dms-cloudwatch-logs-role"
  }
}
resource "aws_iam_policy_attachment" "policy-role-cloudwatch-attach" {
  name       = "dms-cloudwatch-role-attachment"
  roles      = ["${aws_iam_role.dms-cloudwatch-logs-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
}