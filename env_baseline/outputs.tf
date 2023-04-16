output "env_folder" {
  description = "Environment folder created under parent."
  value       = google_folder.env.name
}

output "monitoring_project_id" {
  description = "Project for monitoring infra."
  value       = module.monitoring_project.project_id
}

output "base_shared_vpc_project_id" {
  description = "Project for base shared VPC network."
  value       = module.base_shared_vpc_host_project.project_id
}

output "restricted_shared_vpc_project_id" {
  description = "Project for restricted shared VPC network."
  value       = module.restricted_shared_vpc_host_project.project_id
}

output "env_secrets_project_id" {
  description = "Project for environment secrets."
  value       = module.env_secrets.project_id
}
