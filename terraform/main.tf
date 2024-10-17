
locals {
  container_config = {
    memory        = 512
    cpu           = 256
    container_port = 5000
    host_port     = 5000
    protocol      = "tcp"
    image         = "public.ecr.aws/999999999/my_app:latest"
    name          = "my_app-container"
  }
}
module "vpc" {
  source = "./modules/vpc"
  app_name = var.app_name
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = module.vpc.vpc_id
  name   = "ecs-security-group"
  ingress {
    from_port   = local.container_config.host_port
    to_port     = local.container_config.host_port
    protocol    = local.container_config.protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ecs_service" {
  source = "./modules/ecs-service-module"
  
  app_name  = var.app_name
  subnets_ids = module.vpc.public_subnet_ids
  container_config = local.container_config
  execution_role_arn = "" //not needed for now 
  security_groups_ids = [aws_security_group.ecs_sg.id]
}
