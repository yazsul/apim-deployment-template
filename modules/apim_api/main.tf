provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}


# ----------------------------------------
# API Version Set (mandatory for versioning)
# ----------------------------------------
resource "azurerm_api_management_api_version_set" "version_set" {
  name                = var.api_version_set_name
  display_name        = "${var.api_display_name} Version Set"
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name
  versioning_scheme   = var.api_versioning_scheme
}

# ----------------------------------------
# Backend (referenced by API)
# ----------------------------------------
resource "azurerm_api_management_backend" "backend" {
  name                = var.backend_name
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name

  protocol = "http"
  url      = var.backend_url
}

# ----------------------------------------
# API
# ----------------------------------------
resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name
  revision            = "1"
  display_name        = var.api_display_name
  path                = var.api_path
  protocols           = ["https"]

  version             = var.api_version
  version_set_id      = azurerm_api_management_api_version_set.version_set.id
  version_description = "Version ${var.api_version}"

  service_url = var.backend_url

  import {
    content_format = "openapi+json-link"
    content_value  = var.api_spec_url
  }
}

# ----------------------------------------
# Product
# ----------------------------------------
resource "azurerm_api_management_product" "product" {
  product_id          = var.product_name
  display_name        = var.product_display
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name

  subscription_required = true
  approval_required     = false
  published             = true
}

# ----------------------------------------
# Product Policy (from controlled templates)
# ----------------------------------------
resource "azurerm_api_management_product_policy" "product_policy" {
  product_id          = azurerm_api_management_product.product.product_id
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name

  xml_content = file("${path.module}/policies/${var.policy_template}.xml")
}

# ----------------------------------------
# Link API to Product
# ----------------------------------------
resource "azurerm_api_management_product_api" "link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.product.product_id
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name
}