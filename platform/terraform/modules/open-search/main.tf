
resource "aws_security_group" "datahub_open_search_security_group" {
  name        = "${var.vpc_name}-opensearch-${var.domain}"
  description = "Managed by Terraform"
  vpc_id      = local.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    # Needs to provide selected cidr block instead of complete VPC Cidr Block
    cidr_blocks = [
      local.vpc_cidr_block
    ]
  }
}

# module "security-group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.1.0"
#   ingress_cidr_blocks = []
# }


resource "aws_iam_service_linked_role" "datahub_open_search_iam_service_role" {
  aws_service_name = "opensearchservice.amazonaws.com"
}

resource "random_password" "open_search_master_user_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_opensearch_domain" "open_search_instance" {
  domain_name    = var.domain
  engine_version = "OpenSearch_1.0"

  advanced_security_options {
    enabled                        = false
    anonymous_auth_enabled         = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = "opensearch"
      master_user_password = random_password.open_search_master_user_password.result
    }
  }

  cluster_config {
    instance_type          = var.open_search_instance_type
    zone_awareness_enabled = true
  }

  encrypt_at_rest {
    enabled = false
  }

  domain_endpoint_options {
    custom_endpoint_enabled = false
    enforce_https           = true
    tls_security_policy     = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 100
    volume_type = "gp2"
  }

  # log_publishing_options {
  #   enabled = false
  # }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids         = local.subnet_ids
    security_group_ids = [aws_security_group.datahub_open_search_security_group.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = data.aws_iam_policy_document.os_iam_policy_document.json

  tags = {
    Domain = var.domain
  }

  depends_on = [aws_iam_service_linked_role.datahub_open_search_iam_service_role]
}
