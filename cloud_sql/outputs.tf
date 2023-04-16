output "sql_instance_name" {
  description = "The instance name for the master instance"
  value       = var.database_type == "mysql" ? module.mysql.0.instance_name : var.database_type == "postgres" ? module.postgres.0.instance_name : var.database_type == "mssql" ? module.mssql.0.instance_name : ""
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = var.database_type == "mysql" ? module.mysql.0.private_ip_address : var.database_type == "postgres" ? module.postgres.0.private_ip_address : var.database_type == "mssql" ? module.mssql.0.private_address : ""
}

output "database_password_secret" {
  description = "Secret id where the random password generated for root/user is stored"
  value       = google_secret_manager_secret.secrets.id
}
