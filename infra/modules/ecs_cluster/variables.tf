variable "SERVICE_NAME" {
  description = "The name of the service being deployed to ecs"
  type        = string
}

variable "ECR_REPO_URL" {
  description = "The url of the ecr repo"
  type        = string
}

variable "TASK_EXECUTION_ROLE_ARN" {
  description = "Role arn for execution task role"
  type        = string
}
