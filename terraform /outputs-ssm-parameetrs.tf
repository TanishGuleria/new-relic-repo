module "output_string_parameters" {

  source = "./modules/outputs-ssm-paramters"
  providers = {
    aws = aws.parameters
  }
  parameters = [
    {
      name        = "/${var.app_name}/s3-bucket/name"
      value       = module.s3_bucket.bucketName
      description = "S3 bucket id for app ${var.app_name}"
    },
  ]
}