data "aws_iam_policy_document" "es_iam_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["66.193.100.22/32"]
    }
  }
}
