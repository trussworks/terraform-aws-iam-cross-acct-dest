This module creates a role based on the "iam_role_name" variable that can be assumed by the roles listed in "source_account_role_names" from the account id defined in the "source_account_id" variable.

The role in the source account must exist before creating this resource. This module should be paired with the iam-cross-acct-src module to create a role in the source account with permissions to assume the role created in this module. In certain cases, the trusted relationship between source and destination may be account-based rather than role based.

The source assume role call defaults to requiring MFA.

_Philosophical note_: There should be a single account in your AWS organization that manages users and groups. In that account, there will be a 1:1 mapping to a group and a role. That role may have AssumeRole permissions to multiple other roles across the accounts in the AWS organization.
The role defined in this module should be one of those roles that can be assumed by the role in the original user management account.
Generally speaking, the role defined in this module should also map 1:1 to that original group for access concerns. An IAM policy should be defined locally in this account for permissions and assigned to the role defined here.

This module works on GovCloud.

## Terraform Versions

Terraform 0.13. Pin module version to ~> 3.X. Submit pull-requests to master branch.
Terraform 0.12. Pin module version to ~> 2.0.1. Submit pull-requests to terraform012 branch.

## Usage

In most cases, you will just use the `source_account_id` parameter to trust the user and group managment account; you can then keep all management of which of those users and groups can assume roles there. The following code illustrates that pattern:

```hcl
module "aws_iam_dest_user_group_role" {
  source  = "trussworks/iam-cross-acct-dest/aws"
  version = "3.0.0"

  iam_role_name     = "group-name"
  source_account_id = "account-id"
}

```

However, if you want to make the dependency on the source role explicit, you can do it by adding the `source_account_role_names` parameter, like the following example. This uses [IAM role chaining](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html), which is not a recommended method as it institutes a number of restrictions; see the docs for more information.

```hcl
module "aws_iam_dest_user_group_role" {
  source = "trussworks/iam-cross-acct-dest/aws"
  version = "3.0.0"
  iam_role_name = "group-name"
  source_account_id = "account-id"
  source_account_role_names = ["group-name"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name for the created role. Conceptually, this should correspond to a group. | `string` | n/a | yes |
| <a name="input_mfa_condition"></a> [mfa\_condition](#input\_mfa\_condition) | MFA condition method. Use either Bool or BoolIfExists | `string` | `"Bool"` | no |
| <a name="input_path"></a> [path](#input\_path) | path to IAM role | `string` | `null` | no |
| <a name="input_require_mfa"></a> [require\_mfa](#input\_require\_mfa) | Whether the created policy will include MFA. | `bool` | `true` | no |
| <a name="input_role_assumption_max_duration"></a> [role\_assumption\_max\_duration](#input\_role\_assumption\_max\_duration) | Max duration that the assumed role is assumed for Must be between 3600 and 43200 (including) | `number` | `3600` | no |
| <a name="input_source_account_id"></a> [source\_account\_id](#input\_source\_account\_id) | The account id that the assume role call will be coming from. | `string` | n/a | yes |
| <a name="input_source_account_role_names"></a> [source\_account\_role\_names](#input\_source\_account\_role\_names) | The name of the role that the assume role call will be coming from. Again, this should correspond to a group. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the created role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
