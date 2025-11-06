resource "aws_mq_broker" "main" {
  broker_name = var.broker_name

  engine_type        = "RabbitMQ"
  engine_version     = var.engine_version
  host_instance_type = var.host_instance_type
  deployment_mode    = var.deployment_mode

  publicly_accessible = var.publicly_accessible
  subnet_ids          = var.deployment_mode == "SINGLE_INSTANCE" ? [var.subnet_ids[0]] : var.subnet_ids
  security_groups     = var.security_groups

  user {
    username = var.username
    password = var.password
  }

  dynamic "user" {
    for_each = { for idx, u in var.additional_users : idx => u }
    content {
      username = user.value.username
      password = user.value.password
    }
  }

  logs {
    general = var.enable_general_logs
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_day_of_week
    time_of_day = var.maintenance_time_of_day
    time_zone   = var.maintenance_time_zone
  }

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  storage_type               = var.storage_type

  tags = merge(
    var.tags,
    {
      Name = var.broker_name
    }
  )
}
