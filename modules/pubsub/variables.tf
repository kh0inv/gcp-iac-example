variable "pubsub_topic_name" {
  description = "The name of the pubsub topic."
  type        = string
  default     = ""
}

variable "pubsub_subscription_name" {
  description = "The name of the pubsub subscription."
  type        = string
  default     = ""
}

variable "ack_deadline" {
  description = "The name of the pubsub subscription."
  type        = number
  default     = 20
}

variable "push_endpoint" {
  description = "A URL locating the endpoint to which messages should be pushed."
  type        = string
  default     = ""
}

variable "push_auth_service_account_email" {
  description = "Service account email to be used for generating the OIDC token with push delivery."
  type        = string
  default     = ""
}

variable "enable_push_authentication" {
  description = "Allow Pub/Sub to create authentication tokens in your project."
  type        = bool
  default     = false
}
