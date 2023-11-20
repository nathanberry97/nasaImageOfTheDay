variable "VPC_SUBNETS" {
  description = "AWS VPC subnets IDs"
  type        = list(string)
}

variable "ECR_REPO_URL" {
  description = "The url of the ecr repo"
  type        = string
}

variable "SERVICE_NAME" {
  description = "The name of the service being deployed to ecs"
  type        = string
  default     = "nasa_apod"
}

variable "ECS_EXECUTION_ROLE_NAME" {
  description = "The name of the ecs execution role"
  type        = string
  default     = "nasaApodEcsTaskExecutionRole"
}

variable "EVENT_BRIDGE_ROLE_NAME" {
  description = "The name of the event bridge role"
  type        = string
  default     = "nasaApodEventRole"
}

variable "CRON" {
  description = "The cron schedule of the ecs task"
  type        = string
  default     = "cron(0 8 * * ? *)"
}
