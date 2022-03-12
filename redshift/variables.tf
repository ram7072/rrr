variable "environment_values" {
  default = {
    default = {
      database_name            = "testdb"
      master_username          = "testuser"
      master_password          = "Dba_2019"
      node_type                = "dc2.large" # Valid Values: dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ds2.xlarge | ds2.8xlarge.
      publicly_accessible      = "false"
      number_of_nodes          = 1
      port                     = 5439
      cluster_identifier       = "pge-redshift-cluster3"
      subnets                  = ["subnet-019267e8425253d0b", "subnet-019267e8425253d0b"]
      whitelist_cidr_blocks    = ["0.0.0.0/0"]
      iam_roles                = ["arn:aws:iam::755231362028:role/myRedshiftRole"]
      skip_final_snapshot      = true
      vpc_id                   = "vpc-0ee2ef30d68a46393"
      from_port                = 5439
      to_port                  = 5439
      protocol                 = "tcp"
      redshift_subnet_grp_name = "redshift-pge-subnet-grp1"
      redshift_sg_name         = "redshift_sg_01"
    }
    test = {
      database_name         = "pgedwtest"
      master_username       = "dwadmin"
      master_password       = "Dba_2019"
      node_type             = "ds2.xlarge" # Valid Values: dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ds2.xlarge | ds2.8xlarge.
      publicly_accessible   = "false"
      number_of_nodes       = 3
      port                  = 5439
      cluster_identifier    = "pge-redshift-cluster-test"
      subnets               = ["subnet-074bfa25780ca56d4"]
      whitelist_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12"]
      #roles should be created automatically
      iam_roles                = ["arn:aws:iam::679494167814:role/aws-service-role/redshift.amazonaws.com/AWSServiceRoleForRedshift", "arn:aws:iam::679494167814:role/dsm-datalake-redshift"]
      skip_final_snapshot      = true
      vpc_id                   = "vpc-0a24a9a6a1f0cec4e"
      from_port                = 5439
      to_port                  = 5439
      protocol                 = "tcp"
      redshift_subnet_grp_name = "dsm-datalake-redshift-subnet-grp"
      redshift_sg_name         = "redshift_sg_01"
      encrypted                = true
    }
    preprod = {}
    prod = {
      database_name         = "pgedwprod"
      master_username       = "dwadmin"
      master_password       = "Dba_2019"
      node_type             = "ds2.xlarge" # Valid Values: dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ds2.xlarge | ds2.8xlarge.
      publicly_accessible   = "false"
      number_of_nodes       = 3
      port                  = 5439
      cluster_identifier    = "pge-redshift-cluster-prod"
      subnets               = ["subnet-08ed825ae0f481475", "subnet-0d806070fa49effdd"]
      whitelist_cidr_blocks = ["172.16.0.0/12", "192.168.0.0/16", "147.79.224.0/20", "147.79.240.0/20", "147.79.176.0/20", "10.94.64.0/24"]
      #roles should be created automatically
      iam_roles                = ["arn:aws:iam::679494167814:role/aws-service-role/redshift.amazonaws.com/AWSServiceRoleForRedshift", "arn:aws:iam::679494167814:role/dsm-datalake-redshift"]
      skip_final_snapshot      = true
      vpc_id                   = "vpc-0bbee56735ab12ca8"
      from_port                = 5439
      to_port                  = 5439
      protocol                 = "tcp"
      redshift_subnet_grp_name = "dsm-datalake-redshift-subnet-grp"
      redshift_sg_name         = "redshift_sg_01"
      encrypted                = true
    }
  }
}

