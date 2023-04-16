variable "hub_project_id" {
  type        = string
  description = "Fortress Hub project id."
}

variable "spoke_project_id" {
  type        = string
  description = "Fortress Spoke project id."
  default     = ""
}

variable "spoke_folder_name" {
  type        = string
  description = "Fortress Spoke Folder Name."
  default     = ""
}

variable "sa_prefix" {
  type        = string
  description = "Fortress Spoke Folder Name."
  default     = "slz"
}

variable "deployment" {
  type        = string
  description = "Hub|Spoke|Folder"
  default     = "spoke"
  validation {
    condition     = contains(["spoke", "hub", "folder"], var.deployment)
    error_message = "Valid values for var: deployment are hub|spoke|folder."
  }
}
