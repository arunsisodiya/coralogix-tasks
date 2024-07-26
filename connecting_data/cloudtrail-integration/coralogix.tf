######################################################
#            CORALOGIX BLOCK CONFIGURATION           #
######################################################

module "coralogix-shipper-cloudtrail" {
  source                 = "coralogix/aws/coralogix//modules/s3"
  version                = "1.0.61"
  coralogix_region       = "Custom"
  custom_url             = var.custom_url
  private_key            = var.private_key
  application_name       = "AWS"
  subsystem_name         = "CloudTrail"
  s3_bucket_name         = var.s3_bucket_name
  integration_type       = "cloudtrail"
  create_secret          = "True"
  secret_manager_enabled = false
  layer_arn              = ""
  newline_pattern        = "(?:\r\n|\r|\n)"
  blocking_pattern       = ""
  buffer_size            = 134217728
  sampling_rate          = 1
  debug                  = false
  memory_size            = 1024
  timeout                = 300
  architecture           = "x86_64"
  s3_key_prefix          = null
  s3_key_suffix          = null
  notification_email     = "arunsingh1801@gmail.com"
  custom_s3_bucket       = ""
}
