# Create a secret in Secretsmanager

![License](https://img.shields.io/github/license/terrablocks/aws-secretsmanager?style=for-the-badge) ![Tests](https://img.shields.io/github/workflow/status/terrablocks/aws-secretsmanager/tests/main?label=Test&style=for-the-badge) ![Checkov](https://img.shields.io/github/workflow/status/terrablocks/aws-secretsmanager/checkov/main?label=Checkov&style=for-the-badge) ![Commit](https://img.shields.io/github/last-commit/terrablocks/aws-secretsmanager?style=for-the-badge) ![Release](https://img.shields.io/github/v/release/terrablocks/aws-secretsmanager?style=for-the-badge)

This terraform module will setup the following services:
- Secretsmanager

# Usage Instructions
## Example
```terraform
module "secret" {
  source = "github.com/terrablocks/aws-secretsmanager.git"

  name          = "terrablocks"
  secret_string = "Secret"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.15 |
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the secret | `string` | n/a | yes |
| description | Description for the secret | `string` | `"Created by terrablocks"` | no |
| kms_key | ID/ARN/Alias of the KMS key to use for encrypting the data stored in the secret | `string` | `"alias/aws/secretsmanager"` | no |
| delete_after_days | Number of days Secretsmanager should wait before deleting the secret. It should be between 7 to 30 but can be set to 0 to force delete the secret | `number` | `0` | no |
| replica | To replicate your secret to another region. Note: Only block is accepted<pre>[{<br>  kms_key = ID/ARN/Alias of the KMS key to use in the destination region<br>  region  = ID of the region where secret needs to be replicated<br>}]</pre> | <pre>list(object({<br>    kms_key = string<br>    region  = string<br>  }))</pre> | `[]` | no |
| overwrite_replica_secret | Whether to overwrite the secret in the replica region if already present | `bool` | `true` | no |
| secret_string | Text data that you want to encrypt and store in the secret. **Note:** Either `secret_string` or `secret_binary` must be provided | `string` | `null` | no |
| secret_binary | Binary data encoded in base64 format that you want to encrypt and store in the secret. **Note:** Either `secret_string` or `secret_binary` must be provided | `string` | `null` | no |
| policy | Resource policy to apply to the secret | `string` | `"{}"` | no |
| enable_auto_rotation | Whether to automatically updated the secret periodically | `bool` | `false` | no |
| lambda_arn | ARN of lambda function that will rotate the secret | `string` | `null` | no |
| rotate_after_days | Number of days after which the secret must be rotated | `number` | `60` | no |
| tags | Map of key-value pair to associate with the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the secret |
| version_id | Version ID of the secret |
