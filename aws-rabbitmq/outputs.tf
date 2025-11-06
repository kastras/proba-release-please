output "broker_id" {
  description = "The unique ID that Amazon MQ generates for the broker"
  value       = aws_mq_broker.main.id
}

output "broker_arn" {
  description = "The ARN of the broker"
  value       = aws_mq_broker.main.arn
}

output "broker_console_url" {
  description = "The URL of the broker's web console"
  value       = aws_mq_broker.main.instances[0].console_url
}

output "broker_endpoints" {
  description = "The broker's wire-level protocol endpoints"
  value       = aws_mq_broker.main.instances[0].endpoints
}

output "broker_ip_address" {
  description = "The IP address of the broker"
  value       = aws_mq_broker.main.instances[0].ip_address
}
