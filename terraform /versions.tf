locals {
  common_tags = {
    Application  = var.app_name
    BusinessUnit = "CPG"
    Origin       = var.tag_origin
    OwnerEmail   = "cre@sophos.com"
    Project      = "team-name-project"
    Function     = "team-name-function"
    Team         = "cre"
  }
}

# TODO: Move to terraform version pin
terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
  required_version = "1.3.5"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = local.common_tags
  }
}

#store every ssm paramters in diffrent region 
provider "aws" {
  alias  = "parameters"
  region = var.account_parameters_store_region

  default_tags {
    tags = local.common_tags
  }
}