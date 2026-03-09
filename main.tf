module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  vnet_name        = "vnet-sandbox"
  address_space    = ["10.0.0.0/16"]
  subnet_names     = ["subnet-compute", "subnet-appgw"]
  subnet_prefixes  = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = var.tags
}

data "azurerm_client_config" "current" {}

module "keyvault" {
  source = "./modules/keyvault"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  keyvault_name = "kv-sandbox-${random_integer.suffix.result}"
  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = data.azurerm_client_config.current.object_id

  tags = var.tags
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

module "vm" {
  source = "./modules/vm"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  vm_name        = "vm-sandbox"
  subnet_id      = module.networking.subnet_ids[0]
  admin_username = "azureuser"
  ssh_public_key = var.ssh_public_key

  tags = var.tags
}

module "app_gateway" {
  source = "./modules/app_gateway"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  appgw_name = "appgw-sandbox"
  subnet_id  = module.networking.subnet_ids[1]

  tags = var.tags
}

module "apim" {
  source = "./modules/apim"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  apim_name       = "apim-sandbox-${random_integer.suffix.result}"
  publisher_name  = "Sandbox Team"
  publisher_email = "admin@example.com"

  tags = var.tags
}

module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  storage_account_name = "stsandbox${random_integer.suffix.result}"

  tags = var.tags
}

module "sql_database" {
  source = "./modules/sql_database"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  sql_server_name = "sqlsandbox${random_integer.suffix.result}"
  database_name   = "db-sandbox"

  admin_username = var.sql_admin_username
  admin_password = var.sql_admin_password

  tags = var.tags
}

module "app_service" {
  source = "./modules/app_service"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  app_service_plan_name = "plan-sandbox"
  web_app_name          = "app-sandbox-${random_integer.suffix.result}"

  tags = var.tags
}

module "frontdoor" {
  source = "./modules/frontdoor"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  frontdoor_name = "fd-sandbox-${random_integer.suffix.result}"
  endpoint_name  = "fd-endpoint"

  origin_host_name = module.app_service.web_app_url

  tags = var.tags
}