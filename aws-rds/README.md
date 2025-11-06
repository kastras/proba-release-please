# AWS RDS Terraform Module

This module creates an AWS RDS database instance with a subnet group.

## Features

- RDS instance with customizable engine (PostgreSQL, MySQL, MariaDB, etc.)
- DB subnet group configuration
- Storage encryption support
- Automated backups with configurable retention
- Multi-AZ deployment support
- CloudWatch logs integration
- Customizable maintenance and backup windows

## Usage

```hcl
module "rds" {
  source = "./aws-rds"

  identifier = "my-database"
  engine     = "postgres"
  engine_version = "14.7"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_encrypted = true

  username = "admin"
  password = var.db_password

  subnet_ids             = ["subnet-12345678", "subnet-87654321"]
  vpc_security_group_ids = ["sg-12345678"]

  backup_retention_period = 7
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = false

  tags = {
    Environment = "production"
    Project     = "myapp"
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
| identifier | The name of the RDS instance | `string` | n/a | yes |
| engine | The database engine to use | `string` | `"postgres"` | no |
| engine_version | The engine version to use | `string` | `"14.7"` | no |
| instance_class | The instance type of the RDS instance | `string` | `"db.t3.micro"` | no |
| allocated_storage | The allocated storage in gigabytes | `number` | `20` | no |
| username | Username for the master DB user | `string` | n/a | yes |
| password | Password for the master DB user | `string` | n/a | yes |
| subnet_ids | A list of VPC subnet IDs | `list(string)` | n/a | yes |
| vpc_security_group_ids | List of VPC security groups to associate | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_id | The RDS instance ID |
| db_instance_arn | The ARN of the RDS instance |
| db_instance_endpoint | The connection endpoint |
| db_instance_address | The address of the RDS instance |
| db_instance_port | The database port |
