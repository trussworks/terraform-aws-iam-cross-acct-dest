# Truss Terraform Module template

This repository is meant to be a template repo we can just spin up new module repos from with our general format.

## How to

## Actual readme below  - Delete above here

Please put a description of what this module does here

## Terraform Versions

_This is how we're managing the different versions._
Terraform 0.12. Pin module version to ~> 2.0. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0. Submit pull-requests to terraform011 branch.

## Usage

### Put an example usage of the module here

```hcl
module "example" {
  source = "terraform/registry/path"

  <variables>
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| group\_name | The name for the created role. Conceptually, this should correspond to a group. | string | n/a | yes |
| source\_account | The account id that the assume role call will be coming from. | string | n/a | yes |
| source\_account\_role\_names | The name of the role that the assume role call will be coming from. Again, this should correspond to a group. | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the created role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
