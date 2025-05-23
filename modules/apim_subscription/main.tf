provider "azurerm" {
  features {}
}

data "azurerm_api_management_user" "admin" {
  user_id             = "1"
  api_management_name = var.service_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_subscription" "subscription" {
  display_name        = var.subscription_name
  resource_group_name = var.resource_group_name
  api_management_name = var.service_name
  product_id          = var.product_id
  state               = "active"

  user_id = data.azurerm_api_management_user.admin.id
}