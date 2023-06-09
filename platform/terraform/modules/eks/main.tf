data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = local.cluster_name
}

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", local.cluster_name]
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name              = local.cluster_name
  cluster_version           = var.cluster_version
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  enable_irsa = true

  cluster_addons = {
    aws-ebs-csi-driver = {
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = module.vpc_ebs_csi_role.iam_role_arn
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_group_defaults = {
    disk_size = 10
  }

  eks_managed_node_groups = {
    two = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.instance_types

      attach_cluster_primary_security_group = true

      labels = {
        role        = "appNode"
        Environment = var.environment
      }
    }
  }

  manage_aws_auth_configmap = true


  tags = {
    Environment = var.environment
  }
}
