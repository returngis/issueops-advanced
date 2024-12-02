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

variable "web_name" {
  description = "The name of the web app"
  type        = string

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