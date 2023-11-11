locals {
  ecs_role_name          = var.ECS_EXECUTION_ROLE_NAME
  event_bridge_role_name = var.EVENT_BRIDGE_ROLE_NAME
}

resource "aws_iam_role" "ecs_tas_execution_role" {
  name               = local.ecs_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_tas_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "scheduler" {
  name               = local.event_bridge_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_ecs.json
}

data "aws_iam_policy_document" "assume_role_policy_ecs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "aws_managed_ecs_event_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
  role       = aws_iam_role.scheduler.name
}
