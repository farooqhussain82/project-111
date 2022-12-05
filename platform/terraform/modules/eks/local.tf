locals {
  cluster_name    = "${var.environment}-eks-cluster"
  cluster_version = "1.23"

  tags = {
    Environment = var.environment
  }
}