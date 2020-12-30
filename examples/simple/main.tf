module "test_group_role" {
  source            = "../../"
  iam_role_name     = var.test_name
  source_account_id = var.source_account_id
}

resource "aws_iam_role_policy_attachment" "test_iam_policy" {
  role       = module.test_group_role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}
