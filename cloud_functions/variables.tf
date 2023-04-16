variable "project_id" {
  type        = string
  description = "cloud functions Project id."
}

variable "function_prefix" {
  type        = string
  description = "function prefix"
  default     = "trigger-function"
}

variable "region" {
  type        = string
  description = "cloud functions region."
  default     = "us-east1"
}

variable "runtime" {
  type        = string
  description = "The runtime in which the function is going to run."
  default     = "nodejs14"
}

variable "available_memory_mb" {
  type        = number
  description = "Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc."
  default     = 128
}

variable "trigger_http" {
  type        = bool
  description = "Any HTTP request (of a supported type) to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https_trigger_url. Cannot be used with event_trigger. if it's not http trigger should be null"
  default     = null
}

variable "event_triggers" {
  type        = map(string)
  description = "A source that fires events in response to a condition in another service."
}

variable "entry_point" {
  type        = string
  description = "Name of the function that will be executed when the Google Cloud Function is triggered."
}

variable "invoker_member" {
  type        = string
  description = "cloud functions function iam member with invoker role"
}

variable "storage_bucket_object_source" {
  type        = string
  description = "storage bucket object source zip file with file named function.js inside"
}

variable "bucket_name" {
  type        = string
  description = "storage bucket name that will store the code file"
}

variable "keyring_name" {
  type        = string
  description = "storage bucket keyring name"
}

variable "job_name" {
  type        = string
  description = "The name of the scheduled job to run"
  default     = null
}

variable "job_description" {
  type        = string
  description = "Addition text to describe the job"
  default     = ""
}

variable "job_schedule" {
  type        = string
  description = "The job frequency, in cron syntax"
  default     = "*/2 * * * *"
}

variable "time_zone" {
  type        = string
  description = "The timezone to use in scheduler"
  default     = "Etc/UTC"
}

variable "message_data" {
  type        = string
  description = "The data to send in the topic message."
  default     = "dGVzdA=="
}

variable "topic_name" {
  type        = string
  description = "The topic name."
  default     = "topic-name"
}

variable "create_scheduler_job" {
  type        = bool
  description = "if cloud scheduler job is wanted need to be equal to true"
  default     = false
}

variable "scheduler_http_method" {
  type        = string
  description = "cloud scheduler http method"
  default     = null
}

variable "scheduler_http_body" {
  type        = string
  description = "cloud scheduler http method"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the function."
  default     = {}
}
