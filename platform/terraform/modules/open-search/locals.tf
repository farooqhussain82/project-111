
data "aws_caller_identity" "current" {}

data "aws_vpc" "datahub_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.datahub_vpc.id]
  }
  tags = {
    Name = "aft-app-*"
  }
}

# data "aws_subnets" "vpc_subnet_ids" {
#   for_each = toset(data.aws_subnets.vpc_subnets.ids)
#   id       = each.value
# }

output "xyz" {
  value = data.aws_subnets.vpc_subnets.ids
}
locals {
  vpc_id              = data.aws_vpc.datahub_vpc.id
  aws_caller_identity = data.aws_caller_identity.current
  vpc_cidr_block      = data.aws_vpc.datahub_vpc.cidr_block
  # subnet_ids          = [for subnet in data.aws_subnets.vpc_subnet_ids : subnet.id]
  # es_iam_policy_document = data.aws_iam_policy_document.es_iam_policy_document
}
