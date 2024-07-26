##################################################################
#                  Outputs for S3 backend                        #
##################################################################

output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}