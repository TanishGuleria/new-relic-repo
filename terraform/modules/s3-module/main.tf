
locals{

    bucketName  = "tf-${var.app_name}-${var.region}-bucket"
}

resource "aws_s3_bucket" "bucket" {
  bucket        = local.bucketName
  acl           = "private"
  force_destroy = var.allow_force_destroy

  lifecycle {
    # This prevents terraform from trying to rename a bucket (which will fail if the bucket is not empty)
    ignore_changes = [bucket]
  }

  versioning {
    enabled = true
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.encryption
      }
    }
  }
}