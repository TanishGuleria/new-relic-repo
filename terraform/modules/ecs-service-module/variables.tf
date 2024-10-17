variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "subnets_ids" {
  description = "Public Subnet ids to run farget node on"
  type        = list(string)
}

variable "container_config" {
  type = object({
    memory = number
    cpu = number
    container_port = number
    host_port = number
    protocol =  string
    image = string
    name = string
  })
  
}

variable "execution_role_arn" {
  description = "ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
}

variable "security_groups_ids" {
  description = "Security groups associated with the task or service"
  type        = list(string)
}