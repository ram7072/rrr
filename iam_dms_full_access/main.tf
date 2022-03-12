terraform {
  backend "consul" {
      address = "consul.corp.dom:8500"
          path    = "aws/dl/ec2_iam_dms_fullaccess_state" #purpose
	    }
	    }
provider "aws" {
  region = var.provider_region
}


resource "aws_iam_role" "dms_s3_full_access" {
  name = "dms-s3-fullaccess"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Effect": "Allow",
       "Principal": {
         "Service": "dms.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
} 
EOF
  tags = {
    Name = "dms-s3-fullaccess"
  }
}

resource "aws_iam_role_policy_attachment" "policy-role-attachment1" {
  role      = "${aws_iam_role.dms_s3_full_access.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
