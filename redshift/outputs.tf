output "endpoint" {
  description = "The connection endpoint"
  value       = aws_redshift_cluster.redshift_resource.endpoint
}

output "arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = aws_redshift_cluster.redshift_resource.arn
}

output "dns_name" {
  description = "The DNS name of the cluster"
  value       = aws_redshift_cluster.redshift_resource.dns_name
}

