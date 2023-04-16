output "datastore_index_id" {
  description = "ID of the Datastore Index"
  value       = [for index in google_datastore_index.indexes : index.id]
}
