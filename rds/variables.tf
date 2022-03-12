variable "environment_values" {
  default = {
    default = {
      project                     = "dsm-datalake"
      environment                 = "unknown"
      cluster_node_count          = 1
      vpc_id                      = "vpc-0ae08a07a2c169a83"
      landing_instance_type       = "db.t2.medium"
      target_instance_type        = "db.r4.large"
      allocated_storage           = "32"
      landing_database_name       = "ccbpg01x"
      target_database_name        = "ccbmb01x"
      landing_database_identifier = "landing-postgresql"
      target_database_identifier  = "target-postgresql"
      cluster_identifier          = "csdigital-aurora"
      /*TODO: put in jenkins*/
      database_password          = "tester123"
      database_username          = "test"
      database_port              = "5432"
      backup_retention_period    = "30"
      backup_window              = "04:00-04:30"
      maintenance_window         = "sun:04:30-sun:05:30"
      auto_minor_version_upgrade = true
      subnet_group               = "ccb-pg-sg"
      db_param_group_name        = "postgres-unknown"
      db_param_family            = "postgres10.6"
      db_param_group_desc        = "This DB is creating using Terraform Module"
      cluster_engine             = "aurora-postgresql"
      database_engine            = "postgres"
    }
    test = {
      project            = "dsm-datalake"
      environment        = "test"
      cluster_node_count = 1
      #TODO: test landingzone vpc
      vpc_id                      = "vpc-0a24a9a6a1f0cec4e"
      subnet_ids             = ["subnet-074bfa25780ca56d4","subnet-0daffdeaa573764de"]
      mdm_instance_type       = "db.r4.large"
      cmb_instance_type        = "db.r4.large"
      mdm_database_identifier = "mdm-postgresql"
      cmb_database_identifier  = "cmb-postgresql"
      #TODO: Rename
      mdm_database_name = "mdmpg01t"
      cmb_database_name  = "cmbpg01t"
      #cluster_identifier    = "dsm-datalake"
      mdm_allocated_storage     = "5120"
      cmb_allocated_storage     = "1024"
      /*TODO: put in jenkins*/
      database_password          = "Four_2go"
      database_username          = "dbadmin"
      database_port              = "5432"
      backup_retention_period    = "30"
      backup_window              = "04:00-04:30"
      maintenance_window         = "sun:04:30-sun:05:30"
      auto_minor_version_upgrade = false
      performance_insights_enabled = true
      subnet_group               = "datalake-sg"
      db_param_group_name        = "postgres-unknown"
      db_param_family            = "postgres10.6"
      db_param_group_desc        = "This DB was created using Terraform"
      database_engine        = "postgres"
    }
    prod = {
      project            = "dsm-datalake"
      environment        = "prod"
      cluster_node_count = 1
      #TODO: test landingzone vpc
      vpc_id                      = "vpc-0bbee56735ab12ca8"
      subnet_ids                  = ["subnet-08ed825ae0f481475","subnet-0d806070fa49effdd"]
      mdm_instance_type       = "db.r4.large"
      cmb_instance_type        = "db.r4.large"
      mdm_database_identifier = "mdm-postgresql"
      cmb_database_identifier  = "cmb-postgresql"
      #TODO: Rename
      mdm_database_name = "mdmpg01p"
      cmb_database_name  = "cmbpg01p"
      #cluster_identifier    = "dsm-datalake"
      mdm_allocated_storage     = "5120"
      cmb_allocated_storage     = "1024"
      /*TODO: put in jenkins*/
      database_password          = "Four_2gop"
      database_username          = "dbadmin"
      database_port              = "5432"
      backup_retention_period    = "30"
      backup_window              = "04:00-04:30"
      maintenance_window         = "sun:04:30-sun:05:30"
      auto_minor_version_upgrade = false
      performance_insights_enabled = true
      subnet_group               = "datalake-sg"
      db_param_group_name        = "postgres-unknown"
      db_param_family            = "postgres10.6"
      db_param_group_desc        = "This DB was created using Terraform"
      database_engine        = "postgres"
    }
  }
}

#Set to prod subnets 
#variable "subnet_ids" {
#  default = ["subnet-08ed825ae0f481475","subnet-0d806070fa49effdd"]
#}

#set to prod availibility zones
variable "availability_zones" {
  default = ["us-west-2a","us-west-2b"]
}

variable "allocated_storage" {
  default = "32"
}

variable "engine_version" {
  default = "10.6"
}

variable "instance_type" {
  default = "db.t2.micro"
}

variable "storage_type" {
  default = "gp2"
}

variable "iops" {
  default = "0"
}

variable "database_identifier" {
  default = "test"
}

variable "backup_retention_period" {
  default = "30"
}

variable "backup_window" {
  # 12:00AM-12:30AM ET
  default = "04:00-04:30"
}

variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default = "sun:04:30-sun:05:30"
}

variable "auto_minor_version_upgrade" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

variable "copy_tags_to_snapshot" {
  default = false
}

variable "multi_availability_zone" {
  default = false
}

variable "storage_encrypted" {
  default = true
}

variable "subnet_group" {
  default = "ccb-pg-sg"
}

variable "db_param_group_name" {
  default = "postgres-test"
}

variable "db_param_family" {
  default = "postgres10.6"
}

variable "db_param_group_desc" {
  default = "This DB was created using Terraform"
}

