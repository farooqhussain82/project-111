resource "aws_kms_key" "kms_key_s3_log_bucket" {
  description = "key used for s3 logs bucket"
}

resource "aws_kms_alias" "kms_key_s3_log_bucket_alias" {
  name          = "alias/my-key-alias"
  target_key_id = aws_kms_key.kms_key_s3_log_bucket.key_id
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment}-vpc"
  cidr = var.cidr

  azs = ["${var.region}a", "${var.region}b", "${var.region}c"]

  database_subnets    = var.database_subnets
  public_subnets      = var.public_subnets
  elasticache_subnets = var.elasticache_subnets
  private_subnets     = var.private_subnets
  intra_subnets       = var.intra_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_flow_log           = true
  flow_log_traffic_type     = "ALL"
  flow_log_destination_type = "s3"
  flow_log_destination_arn  = module.vpc_flow_log_s3_bucket.s3_bucket_arn

  public_dedicated_network_acl = true
  public_inbound_acl_rules     = concat(var.default_network_inbound_acl_rules, var.public_network_inbound_acl_rules)
  public_outbound_acl_rules    = concat(var.default_network_inbound_acl_rules, var.public_network_outbound_acl_rules)

  private_dedicated_network_acl     = false
  elasticache_dedicated_network_acl = false

  manage_default_network_acl = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Environment = var.environment
  }

}

resource "random_string" "number" {
  length  = 16
  upper   = false
  lower   = false
  numeric = true
  special = false
}

module "vpc_flow_log_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = local.vpc_flow_log_s3_bucket_name
  policy        = data.aws_iam_policy_document.flow_log_s3.json
  force_destroy = true

  versioning = {
    enabled    = true
    mfa_delete = true
  }

  intelligent_tiering = {
    general = {
      status = "Enabled"
      filter = {
        prefix = "/"
        tags = {
          Environment = var.environment
        }
      }
      tiering = {
        ARCHIVE_ACCESS = {
          days = 180
        }
      }
    }
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.kms_key_s3_log_bucket.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  #tags = var.tags
}

data "aws_iam_policy_document" "flow_log_s3" {
  statement {
    sid = "AWSLogDeliveryWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${local.vpc_flow_log_s3_bucket_name}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = ["arn:aws:s3:::${local.vpc_flow_log_s3_bucket_name}"]
  }
}