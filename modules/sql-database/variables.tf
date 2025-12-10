variable "name" {
  description = "The name of the SQL instance."
  type        = string
}

variable "database_version" {
  description = "The MySQL, PostgreSQL or SQL Server version to use."
  type        = string
  validation {
    condition     = contains(["MYSQL_5_6", "MYSQL_5_7", "MYSQL_8_0", "MYSQL_8_4", "POSTGRES_9_6", "POSTGRES_10", "POSTGRES_11", "POSTGRES_12", "POSTGRES_13", "POSTGRES_14", "POSTGRES_15", "POSTGRES_16", "POSTGRES_17", "SQLSERVER_2017_STANDARD", "SQLSERVER_2017_ENTERPRISE", "SQLSERVER_2017_EXPRESS", "SQLSERVER_2017_WEB", "SQLSERVER_2019_STANDARD", "SQLSERVER_2019_ENTERPRISE", "SQLSERVER_2019_EXPRESS", "SQLSERVER_2019_WEB"], var.database_version)
    error_message = "The database_version must be one of the supported values: MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, MYSQL_8_4, POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14, POSTGRES_15, POSTGRES_16, POSTGRES_17, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB, SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB."
  }
}

variable "location" {
  description = "The region the instance will sit in. If a region is not provided in the resource definition, the provider region will be used instead."
  type        = string
  default     = ""
}

variable "root_password" {
  description = "Initial root password. Can be updated. Required for MS SQL Server."
  type        = string
  default     = ""
}

variable "settings" {
  description = "The settings to use for the database."
  type = object({
    tier              = string
    edition           = optional(string)
    availability_type = optional(string)

    location_preference = optional(object({
      zone           = optional(string)
      secondary_zone = optional(string)
    }))

    data_cache = optional(object({
      data_cache_enabled = optional(bool, false)
    }))

    disk_autoresize_limit = optional(number, 0)
  })
  validation {
    condition     = var.settings.edition == null || contains(["ENTERPRISE", "ENTERPRISE_PLUS"], var.settings.edition)
    error_message = "The edition attribute must be one of: ENTERPRISE, ENTERPRISE_PLUS."
  }
  validation {
    condition     = var.settings.availability_type == null || contains(["REGIONAL", "ZONAL"], var.settings.availability_type)
    error_message = "The availability type must be one of: REGIONAL, ZONAL."
  }
}
