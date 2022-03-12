terraform {
  backend "consul" {
    address = "consul.corp.dom:8500"
    path    = "aws/adms/ec2_loadprofile" #purpose
  }
}

provider "aws" {
  region = var.provider_region
}

locals {
  environment = terraform.workspace
}

#######################################
#######################################

#INBOUND
resource "aws_security_group_rule" "ssh_allow_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = var.environment_values[local.environment]["inbound_cidr_blocks"]
  security_group_id = aws_security_group.ec2_instance_security_group.id
}

resource "aws_security_group_rule" "https_allow_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = var.environment_values[local.environment]["inbound_cidr_blocks"]
  security_group_id = aws_security_group.ec2_instance_security_group.id
}


resource "aws_security_group_rule" "artifactory_inbound" {
  type = "ingress"
  protocol = "tcp"
  from_port = 8081
  to_port = 8081
  cidr_blocks = var.environment_values[local.environment]["inbound_cidr_blocks"]
  security_group_id = aws_security_group.ec2_instance_security_group.id
}

resource "aws_security_group_rule" "allow_all_outbound_traffic" {
    type = "egress"
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    cidr_blocks     = var.environment_values[local.environment]["outbound_cidr_blocks"]
    security_group_id = aws_security_group.ec2_instance_security_group.id
}

#this is the overaerching group that the security rules will be added to.
resource "aws_security_group" "ec2_instance_security_group" {
  name        = "${var.environment_values[local.environment]["project"]}-${var.environment_values[local.environment]["instance_name"]}-security-group"
  description = "security group for ${var.environment_values[local.environment]["instance_name"]}"
  vpc_id      = var.environment_values[local.environment]["vpc_id"]
}



resource "aws_iam_role" "ec2_instance_role"{
  name = "Load_profile_ec2_role"
  description = "Allows Load profile ec2 instance to call AWS services on your behalf."  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "AmazonSSMReadOnlyAccess" {
  role      = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}


resource "aws_iam_role_policy_attachment" "instance_role_policy_attach1" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "instance_role_policy_attach2" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"
}

resource "aws_iam_role_policy_attachment" "instance_role_policy_attach3" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::679494167814:policy/test-kms-access"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "Load_profile_ec2_role"
  role = aws_iam_role.ec2_instance_role.name
}


resource "aws_instance" "ec2_instance" {
  ami                    = var.environment_values[local.environment]["ami_id"]
  instance_type          = var.environment_values[local.environment]["ec2_instance_type"]
  vpc_security_group_ids = [aws_security_group.ec2_instance_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
#  tenancy = "unlimited"
  ebs_optimized = "true"
  disable_api_termination = false
  availability_zone = var.environment_values[local.environment]["availablity_zone"]

  root_block_device {
    volume_size = "400"
  }
  #Per VPC settings in the landing zone, a subnet must be provided to designate where the instance will be launched
  #private ip determined by this subnet
  subnet_id = var.environment_values[local.environment]["subnet_id"]

  key_name = var.environment_values[local.environment]["ec2_key"]
  private_ip = "10.94.99.250"
  user_data = file("./loadprofile_setup.sh")

  tags = {
	Environment = var.environment_values[local.environment]["environment"]
	"Application Name" = var.environment_values[local.environment]["application_name"]
	Confidentiality = var.environment_values[local.environment]["confidentiality"]
	"Cost Center" = var.environment_values[local.environment]["cost_center"]
	"DCIO" = var.environment_values[local.environment]["dcio"]
	"Name" = "ADMS-LoadProfile-ec2-instance"
	"Owner" = var.environment_values[local.environment]["owner"]
	"Project" = var.environment_values[local.environment]["project"]
   AutoOff     = var.environment_values[local.environment]["AutoOff"]

  }
  
}
