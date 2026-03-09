resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name
  sku_name            = "Standard_AzureFrontDoor"

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = var.endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = "origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 120
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = "webapp-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  certificate_name_check_enabled = true

  host_name          = var.origin_host_name
  http_port          = 80
  https_port         = 443
  origin_host_header = var.origin_host_name
  priority           = 1
  weight             = 1000
}


# https://fd-sandbox-xxxxx.z01.azurefd.net