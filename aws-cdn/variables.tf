variable "distribution_name" {
  description = "Name identifier for the CloudFront distribution"
  type        = string
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "comment" {
  description = "Any comments you want to include about the distribution"
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "The object that you want CloudFront to return when an end user requests the root URL"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "The price class for this distribution"
  type        = string
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.price_class)
    error_message = "Price class must be one of: PriceClass_100, PriceClass_200, PriceClass_All."
  }
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names) for this distribution"
  type        = list(string)
  default     = []
}

variable "web_acl_id" {
  description = "The AWS WAF web ACL ID to associate with this distribution"
  type        = string
  default     = null
}

variable "origin_domain_name" {
  description = "The DNS domain name of the origin (e.g., S3 bucket domain or custom origin)"
  type        = string
}

variable "origin_id" {
  description = "A unique identifier for the origin"
  type        = string
  default     = "primary-origin"
}

variable "origin_path" {
  description = "An optional element that causes CloudFront to request your content from a directory in your origin"
  type        = string
  default     = ""
}

variable "origin_type" {
  description = "Type of origin: 's3' or 'custom'"
  type        = string
  default     = "s3"

  validation {
    condition     = contains(["s3", "custom"], var.origin_type)
    error_message = "Origin type must be either 's3' or 'custom'."
  }
}

variable "create_origin_access_identity" {
  description = "Whether to create an Origin Access Identity for S3 origins"
  type        = bool
  default     = true
}

variable "origin_access_identity" {
  description = "Existing Origin Access Identity (if not creating a new one)"
  type        = string
  default     = null
}

variable "custom_origin_http_port" {
  description = "The HTTP port the custom origin listens on"
  type        = number
  default     = 80
}

variable "custom_origin_https_port" {
  description = "The HTTPS port the custom origin listens on"
  type        = number
  default     = 443
}

variable "custom_origin_protocol_policy" {
  description = "The origin protocol policy to apply to your origin"
  type        = string
  default     = "https-only"
}

variable "custom_origin_ssl_protocols" {
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin"
  type        = list(string)
  default     = ["TLSv1.2"]
}

variable "custom_headers" {
  description = "Custom headers to add to origin requests"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "default_cache_allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your origin"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "default_cache_cached_methods" {
  description = "Controls whether CloudFront caches the response to requests"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "forward_query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin"
  type        = bool
  default     = false
}

variable "forward_headers" {
  description = "Specifies the headers that you want CloudFront to forward to the origin"
  type        = list(string)
  default     = []
}

variable "forward_cookies" {
  description = "Specifies which cookies to forward to the origin"
  type        = string
  default     = "none"
}

variable "viewer_protocol_policy" {
  description = "The protocol that viewers can use to access the files in the origin"
  type        = string
  default     = "redirect-to-https"
}

variable "min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches"
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
  default     = 86400
}

variable "compress" {
  description = "Whether you want CloudFront to automatically compress content"
  type        = bool
  default     = true
}

variable "lambda_function_associations" {
  description = "A config block that triggers a Lambda function with specific actions"
  type = list(object({
    event_type   = string
    lambda_arn   = string
    include_body = bool
  }))
  default = []
}

variable "ordered_cache_behaviors" {
  description = "An ordered list of cache behaviors resource for this distribution"
  type = list(object({
    path_pattern           = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    forward_query_string   = bool
    forward_headers        = list(string)
    forward_cookies        = string
    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
    compress               = bool
  }))
  default = []
}

variable "geo_restriction_type" {
  description = "The method that you want to use to restrict distribution of your content by country"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute or not distribute"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "The ARN of the AWS Certificate Manager certificate to use with this distribution"
  type        = string
  default     = null
}

variable "ssl_support_method" {
  description = "Specifies how you want CloudFront to serve HTTPS requests"
  type        = string
  default     = "sni-only"
}

variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  type        = string
  default     = "TLSv1.2_2021"
}

variable "custom_error_responses" {
  description = "One or more custom error response elements"
  type = list(object({
    error_code            = number
    response_code         = optional(number)
    response_page_path    = optional(string)
    error_caching_min_ttl = optional(number)
  }))
  default = []
}

variable "logging_bucket" {
  description = "The Amazon S3 bucket to store the access logs in"
  type        = string
  default     = null
}

variable "logging_prefix" {
  description = "An optional string that you want CloudFront to prefix to the access log filenames"
  type        = string
  default     = "cdn/"
}

variable "logging_include_cookies" {
  description = "Specifies whether you want CloudFront to include cookies in access logs"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
