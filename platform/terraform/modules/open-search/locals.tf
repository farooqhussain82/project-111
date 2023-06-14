
data "aws_caller_identity" "current" {}
locals {
  aws_caller_identity = data.aws_caller_identity.current
}
