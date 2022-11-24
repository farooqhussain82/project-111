module "dev-vpc" {
  source = "../../modules/vpc"

  cidr   = var.cidr
  region = var.region

  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  database_subnets    = var.database_subnets
  elasticache_subnets = var.elasticache_subnets
  intra_subnets       = var.intra_subnets

  default_network_inbound_acl_rules  = var.default_network_inbound_acl_rules
  default_network_outbound_acl_rules = var.default_network_outbound_acl_rules
  public_network_inbound_acl_rules   = var.public_network_inbound_acl_rules
  public_network_outbound_acl_rules  = var.public_network_outbound_acl_rules

}

module "eks-cluster" {
  source = "../../modules/eks"

  environment     = var.environment
  vpc_id          = module.dev-vpc.vpc_id
  private_subnets = module.dev-vpc.private_subnet
  min_size        = var.min_size
  max_size        = var.max_size
  desired_size    = var.desired_size
  instance_types  = var.instance_types
}