
module "open_search_security_group" {
  source        = "terraform-aws-modules/security-group/aws"
  version       = "5.1.0"
  name          = "open_search_security_group"
  description   = "Security group for open search"
  vpc_id        = var.vpc_id
  ingress_rules = ["https-443-tcp"]
}

resource "aws_iam_service_linked_role" "datahub_open_search_iam_service_role" {
  aws_service_name = "opensearchservice.amazonaws.com"
}

resource "random_password" "open_search_master_user_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "datahub_open_search_cloudwatch_log_group" {
  name = "datahub_open_search_cloudwatch_log_group"
}

resource "aws_cloudwatch_log_resource_policy" "datahub_open_search_cloudwatch_resource_policy" {
  policy_name     = "datahub_open_search_cloudwatch_resource_policy"
  policy_document = data.aws_iam_policy_document.datahub_open_search_cloudwatch_resource_policy_document.json
}


resource "aws_opensearch_domain" "datahub_open_search_instance" {
  domain_name    = var.domain
  engine_version = "Elasticsearch_7.10"

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

  log_publishing_options {
    enabled                  = true
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.datahub_open_search_cloudwatch_log_group.arn
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids         = var.app_private_subnets
    security_group_ids = [module.open_search_security_group.security_group_id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = data.aws_iam_policy_document.open_search_iam_policy_document.json

  tags = {
    Domain = var.domain
  }

  depends_on = [module.open_search_security_group, aws_cloudwatch_log_group.datahub_open_search_cloudwatch_log_group, aws_iam_service_linked_role.datahub_open_search_iam_service_role]
}
