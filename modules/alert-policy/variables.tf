variable "display_name" {
  description = "The display name for the alerting policy."
  type        = string
}

variable "combiner" {
  description = "The combiner specifies how the results of multiple conditions are combined. Possible values are AND, OR, and AND_WITH_MATCHING_RESOURCE."
  type        = string
  default     = "OR"
  validation {
    condition     = contains(["AND", "OR", "AND_WITH_MATCHING_RESOURCE"], var.combiner)
    error_message = "The combiner must be one of: AND, OR, AND_WITH_MATCHING_RESOURCE."
  }
}

variable "project_id" {
  description = "The project ID to create the alert policy in."
  type        = string
}

variable "instance_name" {
  description = "The name of the VM instance to monitor."
  type        = string
}

variable "notification_email" {
  description = "The email address for the notification channel."
  type        = string
}

variable "notification_email_display_name" {
  description = "The display name for the email notification channel."
  type        = string
  default     = "Email Notification"
}

variable "documentation_content" {
  description = "Documentation to be included in the alert notification."
  type        = string
  default     = "Inbound traffic has exceeded the 500 B/s threshold."
}

variable "threshold_value" {
  description = "The threshold value for the alert condition."
  type        = number
  default     = 500
}
