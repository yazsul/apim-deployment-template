provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

module "petstore_api_example" {
  source = "../../modules/apim_api"

  api_name         = "petstore-api-v1"
  api_display_name = "Petstore API"
  api_path         = "petstore"
  api_spec_url     = "https://petstore3.swagger.io/api/v3/openapi.json"

  api_version           = "v1"
  api_version_set_name  = "petstore"
  api_versioning_scheme = "Segment"

  backend_name = "petstore-backend"
  backend_url  = "https://petstore3.swagger.io/api/v3"

  product_name    = "petstore-product"
  product_display = "Petstore Product"

  policy_template = "external-inbound-base"

  resource_group_name = "rg-api-lab"
  service_name        = "apim-learning"
}

module "petstore_subscription" {
  source              = "../../modules/apim_subscription"
  resource_group_name = "rg-api-lab"
  service_name        = "apim-learning"
  subscription_name   = "petstore-subscription"
  product_id          = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/rg-api-lab/providers/Microsoft.ApiManagement/service/apim-learning/products/petstore-product"
}
