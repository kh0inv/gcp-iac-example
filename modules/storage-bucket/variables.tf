variable "bucket_name" {
  description = "A universally unique name for the bucket. Considered a 'domain name' if the value contains one (or more) period/dot [.]."
  type        = string
}

variable "location" {
  description = "Regional / Dual-Regional / Multi-Regional location of the GCS bucket. Defaults to the google provider's region if nothing is specified here. See https://cloud.google.com/storage/docs/locations#available_locations."
  type        = string
  default     = ""
}

variable "uniform_bucket_level_access" {
  description = "Ensure uniform access to all objects in the bucket by using only bucket-level permissions (IAM). This option becomes permanent after 90 days."
  type        = bool
  default     = false
}

variable "bucket_access_role" {
  description = "The bucket-level role to grant to the entity. This is only applied when `uniform_bucket_level_access` is `true`."
  type        = string
  default     = ""
}

variable "bucket_access_entity" {
  description = "The bucket-level entity to grant access to. This is only applied when `uniform_bucket_level_access` is `true`."
  type        = string
  default     = ""
}
