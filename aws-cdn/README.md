# AWS CDN (CloudFront) Terraform Module

This module creates an AWS CloudFront distribution for content delivery.

## Features

- CloudFront distribution with customizable origins
- Support for S3 and custom origins
- Origin Access Identity (OAI) for S3 buckets
- Custom SSL certificates via ACM
- Multiple cache behaviors
- Lambda@Edge function associations
- Geographic restrictions
- Custom error responses
- Access logging
- Web ACL (AWS WAF) integration
- Compression support

## Usage

### S3 Origin Example

```hcl
module "cdn" {
  source = "./aws-cdn"

  distribution_name = "my-website-cdn"
  comment           = "CDN for my website"
  
  origin_domain_name = "my-bucket.s3.amazonaws.com"
  origin_type        = "s3"
  
  create_origin_access_identity = true
  
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  
  viewer_protocol_policy = "redirect-to-https"
  
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}
```

### Custom Origin Example

```hcl
module "cdn_custom" {
  source = "./aws-cdn"

  distribution_name = "my-api-cdn"
  comment           = "CDN for API"
  
  origin_domain_name = "api.example.com"
  origin_type        = "custom"
  
  custom_origin_protocol_policy = "https-only"
  custom_origin_ssl_protocols   = ["TLSv1.2"]
  
  default_cache_allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  default_cache_cached_methods  = ["GET", "HEAD"]
  
  forward_query_string = true
  forward_cookies      = "all"
  
  tags = {
    Environment = "production"
  }
}
```

### Advanced Example with Custom Domain

```hcl
module "cdn_advanced" {
  source = "./aws-cdn"

  distribution_name = "my-webapp-cdn"
  
  origin_domain_name = "my-bucket.s3.amazonaws.com"
  origin_type        = "s3"
  
  aliases             = ["www.example.com", "example.com"]
  acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxxxx"
  
  custom_error_responses = [
    {
      error_code         = 404
      response_code      = 200
      response_page_path = "/index.html"
      error_caching_min_ttl = 300
    }
  ]
  
  ordered_cache_behaviors = [
    {
      path_pattern           = "/api/*"
      allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
      cached_methods         = ["GET", "HEAD"]
      forward_query_string   = true
      forward_headers        = ["Authorization"]
      forward_cookies        = "all"
      viewer_protocol_policy = "https-only"
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      compress               = true
    }
  ]
  
  logging_bucket = "my-logs-bucket.s3.amazonaws.com"
  logging_prefix = "cdn-logs/"
  
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
| distribution_name | Name identifier for the CloudFront distribution | `string` | n/a | yes |
| origin_domain_name | The DNS domain name of the origin | `string` | n/a | yes |
| origin_type | Type of origin: 's3' or 'custom' | `string` | `"s3"` | no |
| enabled | Whether the distribution is enabled | `bool` | `true` | no |
| price_class | The price class for this distribution | `string` | `"PriceClass_100"` | no |
| default_root_object | The object that CloudFront returns for root URL | `string` | `"index.html"` | no |
| viewer_protocol_policy | The protocol that viewers can use | `string` | `"redirect-to-https"` | no |

## Outputs

| Name | Description |
|------|-------------|
| distribution_id | The identifier for the distribution |
| distribution_arn | The ARN of the distribution |
| distribution_domain_name | The domain name corresponding to the distribution |
| distribution_hosted_zone_id | The CloudFront Route 53 zone ID |
| distribution_status | The current status of the distribution |
