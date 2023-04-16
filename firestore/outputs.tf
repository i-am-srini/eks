output "firestore_documents" {
  description = "Name of the Firestore Document"
  value       = google_firestore_document.firestore_document[*].name
}
