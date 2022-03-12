output "aws_mdm_db_instance" {
  value = aws_db_instance.postgresql_mdm.*
}

output "aws_cmb_db_instance_id" {
  value = aws_db_instance.postgresql_cmb.*
}

output "aws_rds_subnet_group" {
  value = aws_db_subnet_group.rds_subnet_group.id
}

output "aws_rds_security_group" {
  value = aws_db_subnet_group.rds_subnet_group.id
}

