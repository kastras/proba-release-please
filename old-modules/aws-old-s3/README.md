# AWS S3 Terraform Module

This module creates an AWS S3 bucket with security best practices and common configurations.

## Features

- S3 bucket creation
- Server-side encryption (SSE-S3 or SSE-KMS)
- Versioning support
- Public access blocking
- Lifecycle rules for object management
- CORS configuration
- Access logging
- Customizable tags

## Usage

```hcl
module "s3" {
  source = "./aws-s3"

  bucket_name        = "my-application-bucket"
  enable_versioning  = true
  enable_encryption  = true

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}
```

## Advanced Example with Lifecycle Rules

```hcl
module "s3_with_lifecycle" {
  source = "./aws-s3"

  bucket_name        = "my-data-bucket"
  enable_versioning  = true
  enable_encryption  = true

  lifecycle_rules = [
    {
      id              = "archive-old-objects"
      enabled         = true
      expiration_days = 365
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    }
  ]

  cors_rules = [
    {
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["https://example.com"]
      allowed_headers = ["*"]
      max_age_seconds = 3000
    }
  ]

  tags = {
    Environment = "production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | The name of the bucket | `string` | n/a | yes |
| enable_versioning | Enable versioning for the bucket | `bool` | `false` | no |
| enable_encryption | Enable server-side encryption for the bucket | `bool` | `true` | no |
| block_public_acls | Whether Amazon S3 should block public ACLs | `bool` | `true` | no |
| block_public_policy | Whether Amazon S3 should block public bucket policies | `bool` | `true` | no |
| lifecycle_rules | List of lifecycle rules for the bucket | `list(object)` | `[]` | no |
| cors_rules | List of CORS rules for the bucket | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_region | The AWS region this bucket resides in |
