data "aws_iam_policy_document" "os_iam_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["arn:aws:es:${var.aws_region}:${local.aws_caller_identity.account_id}:domain/${var.domain}/*"]

  }
}
