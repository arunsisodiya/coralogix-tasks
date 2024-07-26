##################################################################
#      Variables for CORALOGIX Cloudtrail Integration            #
##################################################################

variable "private_key" {
  description = "The private key for the Coralogix account"
  type        = string
  sensitive   = true
}

variable "custom_url" {
  description = "The CUSTOM URL for the Coralogix account"
  type        = string
  default     = "https://ingress.eu2.coralogix.com/api/v1/logs"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the CloudTrail logs"
  type        = string
}