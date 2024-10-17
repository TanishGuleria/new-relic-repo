variable "account_parameters_store_region" {
  default = "us-east-1"
  type    = string
}

variable "region" {
  description = "The deployment region"
  type        = string
  default     = "eu-west-1"
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "new-relic-cloud-app"
}

variable "image_tag" {
  description = "image tag"
  type        = string
}