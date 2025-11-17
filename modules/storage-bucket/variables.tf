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

variable "use_access_control_lists" {
  description = "If true, we will use `google_storage_bucket_acl` resource to control access to individual buckets or objects, then do not use `google_storage_bucket_access_control` resource."
  type        = bool
  default     = false
}

variable "role_entity_list" {
  description = "A list of role-entity pairs to be applied to the bucket, in the format 'ROLE:entity'. For example: 'OWNER:user@example.com'."
  type        = list(string)
  default     = []
}
