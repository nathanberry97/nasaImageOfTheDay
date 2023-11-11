locals {
  service            = var.SERVICE_NAME
  ecr_url            = var.ECR_REPO_URL
  execution_role_arn = var.TASK_EXECUTION_ROLE_ARN
  cpu_size           = 256
  memory_size        = 512
}

resource "aws_ecs_cluster" "nasa_apod_cluster" {
  name = local.service

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "nasa_apod_task_definition" {
  family                   = local.service
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = local.memory_size
  cpu                      = local.cpu_size
  execution_role_arn       = local.execution_role_arn
  container_definitions    = jsonencode([
    {
      name      = local.service
      image     = local.ecr_url
      cpu       = local.cpu_size
      memory    = local.memory_size
      essential = true
    }
  ])
}
