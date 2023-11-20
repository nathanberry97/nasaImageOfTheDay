locals {
  service                = var.SERVICE_NAME
  ecr_url                = var.ECR_REPO_URL
  subnets                = var.VPC_SUBNETS
  ecs_role_name          = var.ECS_EXECUTION_ROLE_NAME
  event_bridge_role_name = var.EVENT_BRIDGE_ROLE_NAME
  cron                   = var.CRON
}

module "iam_roles" {
  source                  = "./modules/iam_roles"
  ECS_EXECUTION_ROLE_NAME = local.ecs_role_name
  EVENT_BRIDGE_ROLE_NAME  = local.event_bridge_role_name
}

module "ecs_cluster" {
  source                  = "./modules/ecs_cluster"
  TASK_EXECUTION_ROLE_ARN = module.iam_roles.ecs_role_arn
  SERVICE_NAME            = local.service
  ECR_REPO_URL            = local.ecr_url
}

module "event_bridge" {
  source                  = "./modules/event_bridge"
  ECS_CLUSTER_ARN         = module.ecs_cluster.cluser_arn
  ECS_IAM_EXECUTION_ARN   = module.iam_roles.ecs_role_arn
  ECS_TASK_DEFINITION_ARN = module.ecs_cluster.task_definition_arn
  EVENT_IAM_ARN           = module.iam_roles.event_bridge_role_arn
  VPC_SUBNETS             = local.subnets
  CRON                    = local.cron
}
