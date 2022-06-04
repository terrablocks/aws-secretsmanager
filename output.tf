output "secret_arn" {
  value       = local.secret_id
  description = "ARN of the secret"
}

output "secret_version" {
  value       = aws_secretsmanager_secret_version.this.version_id
  description = "Version ID of the secret"
}
