module "output_string_parameters" {

  source = "./modules/outputs-ssm-paramters"
  providers = {
    aws = aws.parameters
  }
  parameters = [
    {
      name        = "/${var.app_name}/ecs-cluster/name"
      value       = module.ecs_service.cluster_name
      description = "ecs cluster name for app ${var.app_name}"
    },
    {
      name        = "/${var.app_name}/sg/id"
      value       = aws_security_group.ecs_sg.id
      description = "sg for for app ${var.app_name}"
    },
    {
      name        = "/${var.app_name}/vpc/id"
      value       = module.vpc.vpc_id
      description = "vpc id app ${var.app_name} is deployed on "
    },
  ]
}