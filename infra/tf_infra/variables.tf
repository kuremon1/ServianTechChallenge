# Access to azure for ressources deployment
variable "rgname" {
  type        = string
  description = "App registration AAD tenant ID"
}
variable "azure_region" {
  type        = string
  description = "Azure region were resources are deployed"
  default     = "North Europe"
  validation {
    condition     = var.azure_region == "North Europe"
    error_message = "Must be valid location"
  }
}

variable "admgrp" {
  description = "Azure AD group name for admins"
  type        = string
}

variable "admgrpid" {
  type        = string
}

variable "acrname" {
  type        = string
}

variable "postgresdb_name" {
  type        = string
}

variable "webapp_name" {
  type        = string
}

variable "key_vault_name" {
  type        = string
}

variable "postgresql_server_name" {
  type        = string
}

variable "dbadmin" {
  type        = string
}

variable "dbpassword" {
  type        = string
}

variable "appserviceplanname" {
  type        = string
}

variable "environment" {
  type        = string
  description = "Environment code (DEV, QA, PPD, PROD)"
  default     = "DEV"
  validation {
    condition     = contains(["dev", "qa", "ppd", "prod"], lower(var.environment))
    error_message = "Must be DEV, QA, PPD, PROD"
  }
}

