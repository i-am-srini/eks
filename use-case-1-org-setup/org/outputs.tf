output "org_id" {
  value       = var.org_id
  description = "The organization id"
}

output "scc_notification_name" {
  value       = var.scc_notification_name
  description = "Name of SCC Notification"
}

output "parent_resource_id" {
  value       = local.parent_resource_id
  description = "The parent resource id"
}

output "parent_resource_type" {
  value       = local.parent_resource_type
  description = "The parent resource type"
}

output "common_folder_name" {
  value       = google_folder.common.name
  description = "The common folder name"
}

output "org_audit_logs_project_id" {
  value       = module.org_audit_logs.project_id
  description = "The org audit logs project ID"
}

output "org_billing_logs_project_id" {
  value       = module.org_billing_logs.project_id
  description = "The org billing logs project ID"
}

output "org_secrets_project_id" {
  value       = module.org_secrets.project_id
  description = "The org secrets project ID"
}

output "interconnect_project_id" {
  value       = module.interconnect.project_id
  description = "The Dedicated Interconnect project ID"
}

output "scc_notifications_project_id" {
  value       = module.scc_notifications.project_id
  description = "The SCC notifications project ID"
}

output "dns_hub_project_id" {
  value       = module.dns_hub.project_id
  description = "The DNS hub project ID"
}

output "base_net_hub_project_id" {
  value       = try(module.base_network_hub[0].project_id, null)
  description = "The Base Network hub project ID"
}

output "restricted_net_hub_project_id" {
  value       = try(module.restricted_network_hub[0].project_id, null)
  description = "The Restricted Network hub project ID"
}

output "logs_export_pubsub_topic" {
  value       = module.pubsub_destination.resource_name
  description = "The Pub/Sub topic for destination of log exports"
}

output "logs_export_storage_bucket_name" {
  value       = module.storage_destination.resource_name
  description = "The storage bucket for destination of log exports"
}

output "access_context_manager_access_policy_id" {
  value       = var.create_acm_policy ? google_access_context_manager_access_policy.access_policy[0].id : null
  description = "The storage bucket for destination of log exports"
}

output "shared_folder" {
  description = "Shared folder created under parent."
  value       = google_folder.common.name
}
