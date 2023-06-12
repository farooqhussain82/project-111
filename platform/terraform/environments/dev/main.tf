module "eks-cluster" {
  source          = "../../modules/eks"
  region          = var.region
  environment     = var.environment
  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets
  min_size        = var.min_size
  max_size        = var.max_size
  desired_size    = var.desired_size
  instance_types  = var.instance_types
}

module "rds-db" {
  source     = "../../modules/rds"
  identifier = var.environment
}
