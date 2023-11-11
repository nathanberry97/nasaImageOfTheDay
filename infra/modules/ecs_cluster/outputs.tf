output "cluser_arn" {
  value = aws_ecs_cluster.nasa_apod_cluster.arn
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.nasa_apod_task_definition.arn
}
