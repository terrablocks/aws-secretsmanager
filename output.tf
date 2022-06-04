output "arn" {
  value       = local.secret_id
  description = "ARN of the secret"
}

output "version_id" {
  value       = aws_secretsmanager_secret_version.this.version_id
  description = "Version ID of the secret"
}
