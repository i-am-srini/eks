variable "project_id" {
  description = "Project id where the firestore is created."
  type        = string
}

variable "location" {
  description = "App Engine Location"
  type        = string
  default     = "us-east1"
}

variable "enable_firestore" {
  description = "Enables Datastore using the App Engine Resource"
  type        = bool
  default     = true
}
