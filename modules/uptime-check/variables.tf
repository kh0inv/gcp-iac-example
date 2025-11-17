variable "display_name" {
  description = "A human-readable name for the Uptime Check configuration."
  type        = string
}

variable "instance_name" {
  description = "The name of the GCE instance to check."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "zone" {
  description = "The zone where the GCE instance is located."
  type        = string
}

variable "timeout" {
  description = "The maximum amount of time to wait for the request to complete (must be between 1 and 60 seconds)"
  type        = string
  default     = "10s"
}

variable "period" {
  description = "How often, in seconds, the uptime check is performed. Currently, the only supported values are 60s (1 minute), 300s (5 minutes), 600s (10 minutes), and 900s (15 minutes). Optional, defaults to 300s"
  type        = string
  default     = "60s"
}

variable "port" {
  description = "The port to connect to. The default is 80."
  type        = number
  default     = 80
}
