data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc]
  }
}

data "aws_subnet" "vpc_subnets" {
  vpc_id = data.aws_vpc.aft_vpc.id
  filter {
    name   = "tag:Name"
    values = var.os_vpc_subnets_name
  }
}

locals {
  vpc_id                 = data.aws_vpc.vpc.id
  subnets                = data.aws_subnet.vpc_subnets.id
  es_iam_policy_document = data.aws_iam_policy_document.es_iam_policy_document.json
}
