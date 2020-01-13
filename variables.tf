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
  type        = list
  default     = []
}

variable "require_mfa" {
  description = "Whether the created policy will include MFA."
  type        = bool
  default     = true
}
