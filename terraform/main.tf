

#Creating S3 Bucket For coloud service  
  
module "s3_bucket" {
  source              = "./modules/s3-module"
  providers = {
    aws = aws
    aws.parameters = aws.parameters 
  }

  # Can also move the module to seperate repo  
  #source = "git::ssh://git@github.com/TanishGuleria/common-terraform-s3-module.git?ref=main" 

  region = data.aws_region.current.name
  app_name = var.app_name
  lifecycle_rule_enabled = true

}

