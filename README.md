This module creates a role based on the "iam_role_name" variable that can be assumed by the roles listed in "source_account_role_names" from the account id defined in the "source_account_id" variable.

The role in the source account must exist before creating this resource. This module should be paried with the iam-cross-acct-src module to create a role in the source account with permissions to assume the role created in this module.

_Philosophical note_: There should be a single account in your AWS organization that manages users and groups. In that account, there will be a 1:1 mapping to a group and a role. That role may have AssumeRole permissions to multiple other roles across the accounts in the AWS organization.
The role defined in this module should be one of those roles that can be assumed by the role in the original user management account.
Generally speaking, the role defined in this module should also map 1:1 to that original group for access concerns. An IAM policy should be defined locally in this account for permissions and assigned to the role defined here.

## Usage

```hcl
module "aws_iam_dest_user_group_role" {
  source = "trussworks/iam-cross-acct-dest/aws"
  version = "1.0.0"
  iam_role_name = "group-name"
  source_account_id = "account-id"
  source_account_role_names = ["group-name"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_role\_name | The name for the created role. Conceptually, this should correspond to a group. | string | n/a | yes |
| source\_account\_id | The account id that the assume role call will be coming from. | string | n/a | yes |
| source\_account\_role\_names | The name of the role that the assume role call will be coming from. Again, this should correspond to a group. | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_name | The name of the created role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
