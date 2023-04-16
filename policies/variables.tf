
variable "org_id" {
  description = "Optional - the organization id to apply the set of policies to."
  type        = string
  default     = ""
}

variable "env" {
  description = "policies environment polder: dev, prod or nonprod"
  type        = string
  default     = "prod"
}

variable "folder_id" {
  description = "Optional - the folder to apply the set of policies to. If organization_id is not empty, the policies will be applied at the organization level."
  type        = string
  default     = ""
}

variable "project_id" {
  description = "Optional - the project to apply the set of policies to. If organization_id or folder_id are not empty, the policies will be applied at organization or folder level."
  type        = string
  default     = ""
}
