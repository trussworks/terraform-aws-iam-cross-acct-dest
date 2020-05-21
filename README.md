This module creates a role based on the "iam_role_name" variable that can be assumed by the roles listed in "source_account_role_names" from the account id defined in the "source_account_id" variable.

The role in the source account must exist before creating this resource. This module should be paired with the iam-cross-acct-src module to create a role in the source account with permissions to assume the role created in this module. In certain cases, the trusted relationship between source and destination may be account-based rather than role based.

The source assume role call defaults to requiring MFA.

_Philosophical note_: There should be a single account in your AWS organization that manages users and groups. In that account, there will be a 1:1 mapping to a group and a role. That role may have AssumeRole permissions to multiple other roles across the accounts in the AWS organization.
The role defined in this module should be one of those roles that can be assumed by the role in the original user management account.
Generally speaking, the role defined in this module should also map 1:1 to that original group for access concerns. An IAM policy should be defined locally in this account for permissions and assigned to the role defined here.

This module works on GovCloud.

## Usage

In most cases, you will just use the `source_account_id` parameter to trust the user and group managment account; you can then keep all management of which of those users and groups can assume roles there. The following code illustrates that pattern:

```hcl
module "aws_iam_dest_user_group_role" {
  source  = "trussworks/iam-cross-acct-dest/aws"
  version = "1.0.3"

  iam_role_name     = "group-name"
  source_account_id = "account-id"
}

```

However, if you want to make the dependency on the source role explicit, you can do it by adding the `source_account_role_names` parameter, like the following example. This uses [IAM role chaining](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html), which is not a recommended method as it institutes a number of restrictions; see the docs for more information.

```hcl
module "aws_iam_dest_user_group_role" {
  source = "trussworks/iam-cross-acct-dest/aws"
  version = "1.0.3"
  iam_role_name = "group-name"
  source_account_id = "account-id"
  source_account_role_names = ["group-name"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iam\_role\_name | The name for the created role. Conceptually, this should correspond to a group. | `string` | n/a | yes |
| require\_mfa | Whether the created policy will include MFA. | `bool` | `true` | no |
| source\_account\_id | The account id that the assume role call will be coming from. | `string` | n/a | yes |
| source\_account\_role\_names | The name of the role that the assume role call will be coming from. Again, this should correspond to a group. | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_name | The name of the created role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
