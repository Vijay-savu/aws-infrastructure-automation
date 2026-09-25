data "aws_caller_identity" "current" {}

output "ansible_ssm_bucket_name" {
  description = "S3 bucket used by Ansible for Systems Manager transfers"
  value       = aws_s3_bucket.ansible_ssm.bucket
}
