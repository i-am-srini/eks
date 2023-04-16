variable "project_id" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "bastion_region" {
  type        = string
  description = "The region of the existing GCP subnetwork for bastion services"
}

variable "bastion_subnet" {
  type        = string
  description = "The name of the existing GCP subnetwork for bastion services"
}

variable "network_project_id" {
  type        = string
  description = "The project id of the existing GCP subnetwork for bastion services"
}

variable "vpc_name" {
  type        = string
  description = "The name of the existing bastion VPC"
}

variable "bastion_name" {
  type        = string
  description = "The name of the bastion server"
}

variable "bastion_zone" {
  type        = string
  description = "The zone for the bastion VM"
}

variable "bastion_service_account_name" {
  type        = string
  description = "Name of new service account to be created for the bastion."
  default     = ""
}

variable "bastion_service_account_email" {
  type        = string
  description = "Email of existing service account to be used for the bastion.(optional)"
  default     = ""
}

variable "repo_project_id" {
  type        = string
  description = "The project where app repos exist (optional)"
  default     = ""
}

variable "vpc_self_link" {
  type        = string
  description = "Self link of existing Bastion VPC(optional)"
  default     = ""
}

variable "bastion_subnet_self_link" {
  type        = string
  description = "Self link of existing Bastion Subnet (Optional)"
  default     = ""
}

variable "other_roles" {
  type        = list(string)
  description = "Roles to add to auto-generated service account (Optional)"
  default     = []
}

variable "enable_container_access" {
  type        = bool
  description = "Auto assign roles to access container clusters (Optional)"
  default     = false
}

variable "bastion_members" {
  type        = list(string)
  description = "Members to add to auto-generated service account to access bastion (Optional)"
  default     = []
}

variable "create_bastion_group" {
  type        = bool
  description = "Create a bastion group"
  default     = false
}

variable "bastion_group_id" {
  type        = string
  description = "The Bastion group Email ID"
  default     = ""
}

variable "bastion_group_owners" {
  type        = list(string)
  description = "The bastion group owners"
  default     = []
}
