output "project_id" {
  value       = var.project_id
  description = "The project's ID"
}

output "df_job_state" {
  description = "The state of the newly created Dataflow job"
  value       = google_dataflow_job.dataflow_job.state
}

output "df_job_id" {
  description = "The unique Id of the newly created Dataflow job"
  value       = google_dataflow_job.dataflow_job.id
}

output "df_job_name" {
  description = "The name of the newly created Dataflow job"
  value       = google_dataflow_job.dataflow_job.name
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = module.dataflow_bucket[0].name
}
