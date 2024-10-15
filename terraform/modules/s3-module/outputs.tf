output "bucketName" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.bucket.id
}

output "region" {
  description = "Region the bucket is created in."
  value       = aws_s3_bucket.bucket.region
}
