data "aws_ssm_parameter" "private_subnets" {
  name = "/aft/provisioned/vpc/private_subnets"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/aft/provisioned/vpc/vpc_cidr"
}

data "aws_ssm_parameter" "database_subnets" {
  name = "/aft/provisioned/vpc/database_subnets"
}

locals {
  vpc_id           = data.aws_ssm_parameter.vpc_id
  vpc_cidr         = data.aws_ssm_parameter.vpc_cidr
  database_subnets = data.aws_ssm_parameter.database_subnets
  private_subnets  = split(",", data.aws_ssm_parameter.private_subnets)
}
