variable "resource_group_name" {
  description = "Azure resource group containing the APIM instance"
  type        = string
}

variable "service_name" {
  description = "Name of the API Management instance"
  type        = string
}

variable "subscription_name" {
  description = "Name of the subscription (used for both name and display name)"
  type        = string
}

variable "product_id" {
  description = "ID of the APIM product to associate the subscription with"
  type        = string
}
