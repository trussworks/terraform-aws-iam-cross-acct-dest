variable "iam_role_name" {
  description = "The name for the created role. Conceptually, this should correspond to a group."
  type        = string
}

variable "source_account_id" {
  description = "The account id that the assume role call will be coming from."
  type        = string
}

variable "source_account_role_names" {
  description = "The name of the role that the assume role call will be coming from. Again, this should correspond to a group."
  type        = list(any)
  default     = []
}

variable "require_mfa" {
  description = "Whether the created policy will include MFA."
  type        = bool
  default     = true
}

variable "role_assumption_max_duration" {
  description = "Max duration that the assumed role is assumed for Must be between 3600 and 43200 (including)"
  type        = number
  default     = 3600
}

variable "mfa_condition" {
  description = "MFA condition method. Use either Bool or BoolIfExists"
  type        = string
  default     = "Bool"
}

variable "path" {
  description = "path to IAM role"
  type        = string
  default     = null
}