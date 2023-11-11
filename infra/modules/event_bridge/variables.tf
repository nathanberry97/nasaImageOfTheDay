variable "ECS_CLUSTER_ARN" {
  description = "The ecs cluser arn"
  type        = string
}

variable "ECS_TASK_DEFINITION_ARN" {
  description = "The ecs task definition arn"
  type        = string
}

variable "ECS_IAM_EXECUTION_ARN" {
  description = "The ecs task execution arn"
  type        = string
}

variable "EVENT_IAM_ARN" {
  description = "The event bridge role arn"
  type        = string
}

variable "CRON" {
  description = "The cron schedule"
  type        = string
}

variable "VPC_SUBNETS" {
  description = "AWS VPC subnets IDs"
  type        = list(string)
}
