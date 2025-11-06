variable "broker_name" {
  description = "The name of the broker"
  type        = string
}

variable "engine_version" {
  description = "The version of RabbitMQ to use"
  type        = string
  default     = "3.11.20"
}

variable "host_instance_type" {
  description = "The broker's instance type"
  type        = string
  default     = "mq.t3.micro"
}

variable "deployment_mode" {
  description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE, CLUSTER_MULTI_AZ"
  type        = string
  default     = "SINGLE_INSTANCE"

  validation {
    condition     = contains(["SINGLE_INSTANCE", "CLUSTER_MULTI_AZ"], var.deployment_mode)
    error_message = "Deployment mode must be either SINGLE_INSTANCE or CLUSTER_MULTI_AZ."
  }
}

variable "publicly_accessible" {
  description = "Whether to enable connections from applications outside of the VPC"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs in which to launch the broker. For SINGLE_INSTANCE, provide one subnet. For CLUSTER_MULTI_AZ, provide two subnets in different AZs"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs assigned to the broker"
  type        = list(string)
}

variable "username" {
  description = "Username of the primary user"
  type        = string
}

variable "password" {
  description = "Password of the primary user"
  type        = string
  sensitive   = true
}

variable "additional_users" {
  description = "List of additional users with username and password"
  type = list(object({
    username = string
    password = string
  }))
  default   = []
  sensitive = true
}

variable "enable_general_logs" {
  description = "Enables general logging via CloudWatch"
  type        = bool
  default     = true
}

variable "maintenance_day_of_week" {
  description = "The maintenance day of the week. e.g., MONDAY, TUESDAY, etc."
  type        = string
  default     = "SUNDAY"
}

variable "maintenance_time_of_day" {
  description = "The maintenance time in 24-hour format. e.g., 02:00"
  type        = string
  default     = "03:00"
}

variable "maintenance_time_zone" {
  description = "The maintenance time zone in either the Country/City format or the UTC offset format"
  type        = string
  default     = "UTC"
}

variable "auto_minor_version_upgrade" {
  description = "Enables automatic upgrades to new minor versions for brokers"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "Storage type of the broker. For mq.m5 broker engine type, use ebs. For mq.t3.micro, use efs"
  type        = string
  default     = "efs"

  validation {
    condition     = contains(["ebs", "efs"], var.storage_type)
    error_message = "Storage type must be either ebs or efs."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

