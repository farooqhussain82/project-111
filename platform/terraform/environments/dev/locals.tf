data "aws_ssm_parameter" "private_subnets" {
  name = "/aft/provisioned/vpc/private_subnets"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/aft/provisioned/vpc/vpc_cidr"
}

data "aws_ssm_parameter" "database_subnet_group" {
  name = "/aft/provisioned/vpc/database_subnet_group"
}

locals {
  private_subnets = split(",", data.aws_ssm_parameter.private_subnets)
  vpc_id = data.aws_ssm_parameter.vpc_id
  vpc_cidr = data.aws_ssm_parameter.vpc_cidr
  database_subnet_group = data.aws_ssm_parameter.database_subnet_group
}
