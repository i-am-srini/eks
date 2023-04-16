output "bigquery_dataset" {
  value       = module.bigquery.bigquery_dataset
  description = "Bigquery dataset resource."
}

output "table_ids" {
  value       = module.bigquery.table_ids
  description = "Unique id for the tables being provisioned"
}
