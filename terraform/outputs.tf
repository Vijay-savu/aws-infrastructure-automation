output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "database_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "database_name" {
  description = "Database name"
  value       = aws_db_instance.postgres.db_name
}

output "load_balancer_dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_lb.application.dns_name
}

output "application_instance_ids" {
  description = "IDs of the application instances"
  value       = [aws_instance.app_1.id, aws_instance.app_2.id]
}