data "aws_partition" "current" {}

data "aws_iam_policy_document" "role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    # can either trust account or specific roles in the account
    principals {
      type        = "AWS"
      identifiers = length(var.source_account_role_names) > 0 ? formatlist(format("arn:${data.aws_partition.current.partition}:iam::%s:role/%%s", var.source_account_id), var.source_account_role_names) : [format("arn:${data.aws_partition.current.partition}:iam::%s:root", var.source_account_id)]
    }

    # Conditionally check if a  valid MFA exists. If require_mfa is
    # set to false don't check for a aws:MultiFactorAuthPresent attribute
    # because it won't exist.
    # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html
    dynamic "condition" {
      for_each = var.require_mfa ? [1] : []
      content {
        test     = var.mfa_condition
        variable = "aws:MultiFactorAuthPresent"
        values   = [tostring(var.require_mfa)]
      }
    }
  }
}

resource "aws_iam_role" "main" {
  name                 = var.iam_role_name
  description          = "Cross-account role for ${var.iam_role_name}"
  assume_role_policy   = data.aws_iam_policy_document.role_assume_role_policy.json
  max_session_duration = var.role_assumption_max_duration
  path                 = var.path
}
