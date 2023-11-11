output "ecs_role_arn" {
  value = aws_iam_role.ecs_tas_execution_role.arn
}

output "event_bridge_role_arn" {
  value = aws_iam_role.scheduler.arn
}
