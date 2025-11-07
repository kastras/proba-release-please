# AWS RabbitMQ Terraform Module

This module creates an Amazon MQ broker for RabbitMQ.

## Features

- RabbitMQ broker using Amazon MQ
- Single instance or multi-AZ cluster deployment
- Customizable instance types
- User management with support for multiple users
- CloudWatch logs integration
- Configurable maintenance windows
- VPC subnet and security group configuration

## Usage

```hcl
module "rabbitmq" {
  source = "./aws-rabbitmq"

  broker_name         = "my-rabbitmq-broker"
  engine_version      = "3.11.20"
  host_instance_type  = "mq.t3.micro"
  deployment_mode     = "SINGLE_INSTANCE"

  subnet_ids          = ["subnet-12345678"]
  security_groups     = ["sg-12345678"]
  publicly_accessible = false

  username = "admin"
  password = var.rabbitmq_password

  enable_general_logs = true
  
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}
```

## Multi-AZ Cluster Example

```hcl
module "rabbitmq_cluster" {
  source = "./aws-rabbitmq"

  broker_name         = "my-rabbitmq-cluster"
  deployment_mode     = "CLUSTER_MULTI_AZ"
  host_instance_type  = "mq.m5.large"

  subnet_ids          = ["subnet-12345678", "subnet-87654321"]
  security_groups     = ["sg-12345678"]

  username = "admin"
  password = var.rabbitmq_password

  additional_users = [
    {
      username = "app_user"
      password = var.app_user_password
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
| broker_name | The name of the broker | `string` | n/a | yes |
| engine_version | The version of RabbitMQ to use | `string` | `"3.11.20"` | no |
| host_instance_type | The broker's instance type | `string` | `"mq.t3.micro"` | no |
| deployment_mode | The deployment mode of the broker | `string` | `"SINGLE_INSTANCE"` | no |
| subnet_ids | List of subnet IDs in which to launch the broker | `list(string)` | n/a | yes |
| security_groups | List of security group IDs assigned to the broker | `list(string)` | n/a | yes |
| username | Username of the primary user | `string` | n/a | yes |
| password | Password of the primary user | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| broker_id | The unique ID that Amazon MQ generates for the broker |
| broker_arn | The ARN of the broker |
| broker_console_url | The URL of the broker's web console |
| broker_endpoints | The broker's wire-level protocol endpoints |
| broker_ip_address | The IP address of the broker |
