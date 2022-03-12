variable "environment_values" {
  default = {
	  dev = {
            #environment specific
	          project     = "adms"
			      vpc_id      = "vpc-0675971f93fd6358f"
            #EC2 specific variables
            instance_name = "loadprofile"
            ec2_instance_type = "t3.large"
            availablity_zone  = "us-west-2a"
            ami_id            = "ami-000b133338f7f4255"
            subnet_id         = "subnet-02dcd13c48c8a2195"
            ec2_key           = "adms-datascience-loadprofile"
            inbound_cidr_blocks        = ["172.16.0.0/12","192.168.0.0/16","147.79.224.0/20","147.79.240.0/20","147.79.176.0/20","10.94.96.0/22","10.0.0.0/8"]
            outbound_cidr_blocks       = ["0.0.0.0/0"]
            AutoOff           = "True"
            environment="Test"
   	        application_name = "ADMS Integration"
            owner = "CloudDataLake@pgn.com"
            project = "ADMS"
            dcio = "GRID"
            confidentiality = "Confidential"
            cost_center = "18100-1840004-XXXXXXXXXXX"
            }
      test = {
            #environment specific
	          project     = "adms"
			      vpc_id      = "vpc-0a24a9a6a1f0cec4e"
            #EC2 specific variables
            instance_name = "loadprofile"
            ec2_instance_type = "t3.large"
            availablity_zone  = "us-west-2b"
            ami_id            = "ami-0e34e7b9ca0ace12d"
            subnet_id         = "subnet-074bfa25780ca56d4"
            ec2_key           = "adms-datascience-loadprofile"
            inbound_cidr_blocks        = ["172.16.0.0/12","192.168.0.0/16","147.79.224.0/20","147.79.240.0/20","147.79.176.0/20","10.94.96.0/22","10.0.0.0/8"]
            outbound_cidr_blocks       = ["0.0.0.0/0"]
            AutoOff           = "True"
            environment="Test"
   	        application_name = "ADMS Integration"
            owner = "CloudDataLake@pgn.com"
            project = "ADMS"
            dcio = "GRID"
            confidentiality = "Confidential"
            cost_center = "18100-1840004-XXXXXXXXXXX"
            }
  }
}

variable "environment" {
  default = "sand"
}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
  default     = "datalake-rstudio-ec2-instance"
}

#For initial testing and development will create m4.large
variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type. Default is m4.large"
  default     = "m4.large"
}

variable "availablity_zone" {
  type        = string
  description = "AWS availability zone for the instance. Defaut is us-west-2c"
  default     = "us-west-2c"
}

variable "vpc_id" {
  type        = string
  description = "ID for PGE VPC"
  default     = "vpc-0ae08a07a2c169a83"
}

#This is the AMI image for Matillion EC2. 
variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance. Defualt is Amazon Linux 2018.3 for Matillion"
  default     = "ami-059d3967d4e6cf467"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id for the ec2 instance to be stored in. Default is Private subnet 1A"
  default     = "subnet-05893704bf7f77dd9"
}

variable "ec2_key" {
  type        = string
  description = "EC2 key pair to allow ssh access"
  default     = "MatillionPOC-SBX"
}

variable "project" {
  type        = string
  description = "project tag for resource"
  default     = "Unknown"
}

variable "provider_region" {
  default = "us-west-2"
}

