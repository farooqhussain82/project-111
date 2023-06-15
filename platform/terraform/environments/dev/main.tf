module "msk_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "msk-security-group"
  description = "Security group for msk with custom ports open within VPC"
  vpc_id      = "var.vpc_id"

  ingress_with_cidr_blocks = [
    {
      from_port   = 9092
      to_port     = 9094
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16" #ToDo Allow only relevant security group
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# module "eks-cluster" {
#   source          = "../../modules/eks"
#   region          = var.region
#   environment     = var.environment
#   vpc_id          = var.vpc_id
#   private_subnets = var.private_subnets
#   min_size        = var.min_size
#   max_size        = var.max_size
#   desired_size    = var.desired_size
#   instance_types  = var.instance_types
# }

# module "rds-db" {
#   source     = "../../modules/rds"
#   identifier = var.environment
# }

module "msk-cluster" {
  source = "../../modules/msk"
  private_subnets = var.private_subnets
  msk_security_group = [module.msk_service_sg.security_group_id]
}
module "datahub-open-search" {
  source              = "../../modules/open-search"
  region              = var.region
  vpc_id              = local.vpc_id
  vpc_cidr            = local.vpc_cidr
  app_private_subnets = local.private_subnets
}
