module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

	enable_irsa = true

	eks_managed_node_groups = {
    one = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.instance_types
    }
  }

	manage_aws_auth_configmap = true

  tags = {
    Name        = local.cluster_name
    Environment = var.environment
    Terraform   = "true"
  }
}

module "vpc_ebs_csi_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "vpc-ebs-csi"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["app1:app1-sa"]
    }
  }
}