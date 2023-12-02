resource "aws_ecs_cluster" "ECS_cluster" {
  name = var.cluster_name
}