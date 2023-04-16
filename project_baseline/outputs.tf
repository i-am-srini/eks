output "project_id" {
  description = "Shared service project id."
  value       = module.project.project_id
}

output "sa" {
  description = "Project SA email"
  value       = module.project.service_account_email
}

output "project_number" {
  description = "Project number."
  value       = module.project.project_number
}
