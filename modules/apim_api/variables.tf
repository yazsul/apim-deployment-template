# ----------------------------------------
# API Definition (REQUIRED)
# ----------------------------------------
variable "api_name" {
  description = "Terraform resource name for the API (e.g., orders-api-v1)"
  type        = string
}

variable "api_display_name" {
  description = "Display name shown in Azure Portal"
  type        = string
}

variable "api_path" {
  description = "Path under the APIM gateway (e.g., 'orders')"
  type        = string
}

variable "api_spec_url" {
  description = "URL to the OpenAPI/Swagger spec file"
  type        = string
}

# ----------------------------------------
# API Versioning (REQUIRED)
# ----------------------------------------
variable "api_version" {
  description = "Version label for the API (e.g., v1, v2)"
  type        = string
}

variable "api_version_set_name" {
  description = "Logical group name linking multiple API versions (e.g., 'orders')"
  type        = string
}

variable "api_versioning_scheme" {
  description = "How versioning is exposed to clients (Segment, Header, or Query) — TO BE DECIDED"
  type        = string
}

# ----------------------------------------
# Backend Configuration (REQUIRED)
# ----------------------------------------
variable "backend_name" {
  description = "Name of the backend service in APIM"
  type        = string
}

variable "backend_url" {
  description = "URL of the actual backend API/service"
  type        = string
}

# ----------------------------------------
# Product Configuration (REQUIRED)
# ----------------------------------------
variable "product_name" {
  description = "Internal product ID (used as resource name)"
  type        = string
}

variable "product_display" {
  description = "Display name of the product"
  type        = string
}

# ----------------------------------------
# Policy Enforcement (REQUIRED)
# ----------------------------------------
variable "policy_template" {
  description = <<DESC
Name of the base policy template to apply at the product level.
Allowed values:
- external-inbound-base
- internal-inbound-base
- external-outbound-base
DESC
  type        = string
}


# ----------------------------------------
# Infrastructure References
# ----------------------------------------
variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "service_name" {
  description = "Name of the API Management instance"
  type        = string
}
