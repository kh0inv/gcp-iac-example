variable "eventarc_trigger_name" {
  description = "The resource name of the trigger. Must be unique within the location on the project."
  type        = string
  default     = ""
}

variable "region" {
  description = "The location (region) of the cloud run service."
  type        = string
  default     = ""
}


variable "cloud_run_service_name" {
  description = "The name of the cloud run service."
  type        = string
  default     = ""
}

variable "pubsub_topic_name" {
  description = "The name of the pubsub topic."
  type        = string
  default     = ""
}
