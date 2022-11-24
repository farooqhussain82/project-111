locals {
  vpc_flow_log_s3_bucket_name = "${var.environment}-flow-log-bucket-${random_string.number.result}"
}