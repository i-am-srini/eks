output "hostname" {
  description = "Host name of the bastion"
  value       = module.iap_bastion.hostname
}

output "ip_address" {
  description = "Internal IP address of the bastion host"
  value       = module.iap_bastion.ip_address
}

output "self_link" {
  description = "Self link of the bastion host"
  value       = module.iap_bastion.self_link
}

output "service_account_email" {
  description = "Email address of the SA created for the bastion host"
  value       = module.iap_bastion.service_account
}

output "cidr_range" {
  description = "Internal IP address range of the bastion host"
  value       = data.google_compute_subnetwork.bastion_subnet[0].ip_cidr_range
}

output "subnet_name" {
  description = "Self link of the bastion host"
  value       = data.google_compute_subnetwork.bastion_subnet[0].name
}

output "group_email" {
  description = "email address of the group - ID"
  value       = var.create_bastion_group ? module.bastion_group[0].id : ""
}
