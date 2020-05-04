data "aws_partition" "current" {}

data "aws_iam_policy_document" "role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    # can either trust account or specific roles in the account
    principals {
      type        = "AWS"
      identifiers = length(var.source_account_role_names) > 0 ? "${formatlist(format("arn:${data.aws_partition.current.partition}:iam::%s:role/%%s", var.source_account_id), var.source_account_role_names)}" : ["${format("arn:${data.aws_partition.current.partition}:iam::%s:root", var.source_account_id)}"]
    }

    # Conditionally require MFA (defaults to true)
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [tostring(var.require_mfa)]
    }
  }
}

resource "aws_iam_role" "main" {
  name               = var.iam_role_name
  description        = "Cross-account role for ${var.iam_role_name}"
  assume_role_policy = data.aws_iam_policy_document.role_assume_role_policy.json
}
