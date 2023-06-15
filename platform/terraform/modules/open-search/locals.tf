
data "aws_caller_identity" "current" {}

data "aws_iam_role" "aws_service_role_open_search" {
  name = "AWSServiceRoleForAmazonOpenSearchService"
}
locals {
  aws_caller_identity             = data.aws_caller_identity.current
  aws_service_role_open_search_id = data.aws_iam_role.aws_service_role_open_search.id
}
