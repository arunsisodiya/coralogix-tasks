##################################################################
#                S3 bucket Module Configuration                  #
##################################################################

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket                   = var.bucket_name
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
  acl                      = "private"
  versioning = {
    status = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}
