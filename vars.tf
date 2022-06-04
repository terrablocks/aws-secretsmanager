variable "name" {
  type        = string
  description = "Name of the secret"
}

variable "description" {
  type        = string
  default     = "Created by terrablocks"
  description = "Description for the secret"
}

variable "kms_key" {
  type        = string
  default     = "alias/aws/secretsmanager"
  description = "ID/ARN/Alias of the KMS key to use for encrypting the data stored in the secret"
}

variable "delete_after_days" {
  type        = number
  default     = 0
  description = "Number of days Secretsmanager should wait before deleting the secret. It should be between 7 to 30 but can be set to 0 to force delete the secret"
}

variable "replica" {
  type = list(object({
    kms_key = string
    region  = string
  }))
  default     = []
  description = <<-EOT
    To replicate your secret to another region. Note: Only block is accepted
    ```[{
      kms_key = ID/ARN/Alias of the KMS key to use in the destination region
      region  = ID of the region where secret needs to be replicated
    }]```
  EOT
}

variable "overwrite_replica_secret" {
  type        = bool
  default     = true
  description = "Whether to overwrite the secret in the replica region if already present"
}

variable "secret_string" {
  type        = string
  default     = null
  description = "Text data that you want to encrypt and store in the secret. **Note:** Either `secret_string` or `secret_binary` must be provided"
}

variable "secret_binary" {
  type        = string
  default     = null
  description = "Binary data encoded in base64 format that you want to encrypt and store in the secret. **Note:** Either `secret_string` or `secret_binary` must be provided"
}

variable "policy" {
  type        = string
  default     = "{}"
  description = "Resource policy to apply to the secret"
}

variable "enable_auto_rotation" {
  type        = bool
  default     = false
  description = "Whether to automatically updated the secret periodically"
}

variable "lambda_arn" {
  type        = string
  default     = null
  description = "ARN of lambda function that will rotate the secret"
}

variable "rotate_after_days" {
  type        = number
  default     = 60
  description = "Number of days after which the secret must be rotated"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of key-value pair to associate with the resource"
}
