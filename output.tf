output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "vnet_id" {
  value = module.networking.vnet_id
}

output "keyvault_id" {
  value = module.keyvault.keyvault_id
}

output "vm_public_ip" {
  value = module.vm.vm_public_ip
}

output "app_gateway_id" {
  value = module.app_gateway.app_gateway_id
}

output "apim_gateway_url" {
  value = module.apim.gateway_url
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name
}

output "sql_database_name" {
  value = module.sql_database.database_name
}

output "web_app_url" {
  value = module.app_service.web_app_url
}

output "frontdoor_url" {
  value = module.frontdoor.frontdoor_url
}