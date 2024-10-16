terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57.0"
    }
  }

  required_version = ">= 1.9.7"
}


#We can also have a common place to set provider version 
# module "aws_module_version_pin" {
#   source = "git::ssh://git@github.com/TanishGuleria/common-terraform-version-pin.git//version_pins/aws_module_version_pin?ref=main"
# }

