output "distribution_id" {
  description = "The identifier for the distribution"
  value       = aws_cloudfront_distribution.main.id
}

output "distribution_arn" {
  description = "The ARN of the distribution"
  value       = aws_cloudfront_distribution.main.arn
}

output "distribution_domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID"
  value       = aws_cloudfront_distribution.main.hosted_zone_id
}

output "distribution_status" {
  description = "The current status of the distribution"
  value       = aws_cloudfront_distribution.main.status
}

output "origin_access_identity_iam_arn" {
  description = "The IAM ARN of the origin access identity (if created)"
  value       = var.create_origin_access_identity ? aws_cloudfront_origin_access_identity.main[0].iam_arn : null
}

output "origin_access_identity_path" {
  description = "The CloudFront origin access identity path (if created)"
  value       = var.create_origin_access_identity ? aws_cloudfront_origin_access_identity.main[0].cloudfront_access_identity_path : null
}
