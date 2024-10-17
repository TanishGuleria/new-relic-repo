resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-ecs-cluster"  
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.app_name}-task"
  network_mode          = "awsvpc"
  memory                = var.container_config.memory
  cpu                   = var.container_config.cpu 
  requires_compatibilities = ["FARGATE"]

  execution_role_arn    = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_config.name
      image     = var.container_config.image
      cpu       = var.container_config.cpu
      memory    = var.container_config.memory
      port_mappings = [
        {
          container_port = var.container_config.container_port
          host_port      = var.container_config.host_port
          protocol       = var.container_config.protocol
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets_ids
    security_groups  = var.security_groups_ids
    assign_public_ip = true
  }
}