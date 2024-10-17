locals {
  common_tags = {
    Application  = var.app_name
    OwnerEmail   = "tsg@gmail.com"
  }
}

terraform {
  #backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
  required_version = "1.9.7"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = local.common_tags
  }
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

#store every ssm paramters in diffrent region 
provider "aws" {
  alias  = "parameters"
  region = var.account_parameters_store_region

  default_tags {
    tags = local.common_tags
  }
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}