terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      configuration_aliases = [aws.parameters]
      version = "~> 5.57.0"
    }
  }

  required_version = ">= 1.3.5"
}


#We can also have a common place to set provider version 
# module "aws_module_version_pin" {
#   source = "git::ssh://git@github.com/TanishGuleria/common-terraform-version-pin.git//version_pins/aws_module_version_pin?ref=main"
# }

