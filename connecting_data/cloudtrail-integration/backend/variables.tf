##################################################################
#                  Variables for S3 backend                      #
##################################################################
variable "region" {
  description = "The region in which the S3 bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state file"
  type        = string
}