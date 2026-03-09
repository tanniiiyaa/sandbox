resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = "Linux"
  sku_name = "F1"   # free tier (if unavailable in region, change to B1)

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {}

  https_only = true

  tags = var.tags
}

# https://app-sandbox-xxxxx.azurewebsites.net