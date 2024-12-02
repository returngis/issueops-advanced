variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "spaincentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create resources"
  type        = string  

  validation {
    condition     = length(var.resource_group_name) <= 90
    error_message = "The resource group name must be at most 90 characters long"
  }

}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string

  validation {
    condition     = length(var.storage_account_name) <= 24
    error_message = "The storage account name must be at most 24 characters long"
  }

  validation {
    condition     = can(regex("^[a-z0-9]*$", var.storage_account_name))
    error_message = "The value cannot contains - or _"
  }

}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.subscription_id) == 36
    error_message = "The subscription ID must be 36 characters long"
  }

}