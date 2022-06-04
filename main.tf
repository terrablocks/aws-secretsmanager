# Issue: https://github.com/hashicorp/terraform-provider-aws/issues/23316
# Due to this issue dynamic block cannot be used for managing replica

resource "aws_secretsmanager_secret" "normal" {
  # checkov:skip=CKV_AWS_149: CMK encryption is a user choice
  count                   = length(var.replica) > 0 ? 0 : 1
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key
  recovery_window_in_days = var.delete_after_days
  policy                  = var.policy
  tags                    = var.tags
}

resource "aws_secretsmanager_secret" "replica" {
  # checkov:skip=CKV_AWS_149: CMK encryption is a user choice
  count                   = length(var.replica) > 0 ? 1 : 0
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key
  recovery_window_in_days = var.delete_after_days
  policy                  = var.policy

  replica {
    kms_key_id = var.replica.0.kms_key
    region     = var.replica.0.region
  }
  force_overwrite_replica_secret = length(var.replica) > 0 ? var.overwrite_replica_secret : null

  tags = var.tags
}

locals {
  secret_id = length(var.replica) > 0 ? join(",", aws_secretsmanager_secret.replica.*.id) : join(",", aws_secretsmanager_secret.normal.*.id)
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = local.secret_id
  secret_string = var.secret_string
  secret_binary = var.secret_binary
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count               = var.enable_auto_rotation ? 1 : 0
  secret_id           = local.secret_id
  rotation_lambda_arn = var.lambda_arn

  rotation_rules {
    automatically_after_days = var.rotate_after_days
  }
}
