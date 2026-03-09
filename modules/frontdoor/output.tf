output "frontdoor_url" {
  value = azurerm_cdn_frontdoor_endpoint.this.host_name
}