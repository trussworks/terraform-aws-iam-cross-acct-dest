data "aws_iam_policy_document" "role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = "${formatlist(format("arn:aws:iam::%s:role/%%s", var.source_account_id), var.source_account_role_names)}"
    }

    # MFA conditional--defaults to true
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [var.mfa_present]
    }
  }
}

resource "aws_iam_role" "main" {
  name               = var.iam_role_name
  description        = "Cross-account role for ${var.iam_role_name}"
  assume_role_policy = data.aws_iam_policy_document.role_assume_role_policy.json
}
