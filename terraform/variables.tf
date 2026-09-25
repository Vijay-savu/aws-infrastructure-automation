variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "my-project"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}