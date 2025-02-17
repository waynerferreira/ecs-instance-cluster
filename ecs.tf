resource "aws_ecs_cluster" "main" {
  name = format ("%s-ecs-cluster-%s-%s", var.project_name, var.env, var.environment)

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name
  

  capacity_providers = var.environment == "dev" ? [
    aws_ecs_capacity_provider.spots.name
  ] : [
    aws_ecs_capacity_provider.on_demand.name,
    aws_ecs_capacity_provider.spots.name
  ]
  
  default_capacity_provider_strategy {
    capacity_provider = var.environment == "dev" ? aws_ecs_capacity_provider.spots.name : aws_ecs_capacity_provider.on_demand.name
    weight            = 100
    base              = 0
  }
}
