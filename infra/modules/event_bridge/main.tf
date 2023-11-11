locals {
  ecs_cluster_arn          = var.ECS_CLUSTER_ARN
  ecs_task_definition_arn  = var.ECS_TASK_DEFINITION_ARN
  ecs_iam_execution_arn    = var.ECS_IAM_EXECUTION_ARN
  ecs_iam_event_bridge_arn = var.EVENT_IAM_ARN
  cron                     = var.CRON
  subnets                  = var.VPC_SUBNETS
}

resource "aws_cloudwatch_event_rule" "scheduled_task" {
  name                = "scheduled-ecs-event-rule"
  schedule_expression = local.cron
}

resource "aws_cloudwatch_event_target" "scheduled_task" {
  target_id = "nasa_apod_event"
  rule      = aws_cloudwatch_event_rule.scheduled_task.name
  arn       = local.ecs_cluster_arn
  role_arn  = local.ecs_iam_event_bridge_arn

  ecs_target {
    task_count          = 1
    task_definition_arn = local.ecs_task_definition_arn
    launch_type         = "FARGATE"
    platform_version    = "LATEST"

    network_configuration {
      assign_public_ip = true
      subnets          = local.subnets
    }
  }
}
