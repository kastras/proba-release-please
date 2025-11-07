variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the bucket"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The AWS KMS key ID used for the SSE-KMS encryption. If not specified, uses AWS managed key (SSE-S3)"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the bucket"
  type = list(object({
    id              = string
    enabled         = bool
    expiration_days = optional(number)
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
  }))
  default = []
}

variable "cors_rules" {
  description = "List of CORS rules for the bucket"
  type = list(object({
    allowed_headers = optional(list(string), [])
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = optional(list(string), [])
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "logging_target_bucket" {
  description = "The name of the bucket that will receive the log objects"
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "The prefix for all log object keys"
  type        = string
  default     = "logs/"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}


