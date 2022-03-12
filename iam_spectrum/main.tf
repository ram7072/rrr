terraform {
  backend "consul" {
      address = "consul.corp.dom:8500"
          path    = "aws/dl/ec2_iam_tf_state" #purpose
	    }
	    }
provider "aws" {
  region = var.provider_region
}


resource "aws_iam_role" "prod_redshift_athena" {
  name = "prod_redshift_athena"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Effect": "Allow",
       "Principal": {
         "Service": "redshift.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
} 
EOF
  tags = {
    Name = "prod_redshift_athena"
  }
}
resource "aws_iam_policy_attachment" "policy-role-attach1" {
  name       = "prod_redshift_athena-attachment1"
  roles      = ["${aws_iam_role.prod_redshift_athena.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}
resource "aws_iam_policy_attachment" "policy-role-attach2" {
  name       = "prod_redshift_athena-attachment2"
  roles      = ["${aws_iam_role.prod_redshift_athena.name}","CSDigital-LambdaEmailRole"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
resource "aws_iam_policy_attachment" "policy-role-attach3" {
  name       = "prod_redshift_athena-attachment3"
  roles      = ["${aws_iam_role.prod_redshift_athena.name}","matillion-ec2-service-role"]
  policy_arn = "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"
}

resource "aws_iam_policy" "custom_kms" {
  # KMS All Access for Custom Keys
  policy = "${file("dmsAssumeRolePolicyDocument.json")}"
}

resource "aws_iam_policy_attachment" "policy-role-attach4" {
  name       = "prod_redshift_athena-attachment4"
  roles      = ["${aws_iam_role.prod_redshift_athena.name}"]
  policy_arn = "arn:aws:iam::554931768202:policy/terraform-20191029205138472000000001"
}
