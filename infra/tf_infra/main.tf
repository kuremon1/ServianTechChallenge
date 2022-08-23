# application resource group
resource "azurerm_resource_group" "stc_rg" {
  name      = var.rgname
  location  = var.azure_region
}

data "azurerm_resource_group" "stc_rg" {
  name = azurerm_resource_group.stc_rg.name
}

# dev team rights on use case resource group for non prod only
resource "azurerm_role_assignment" "dev_team" {
  scope                = data.azurerm_resource_group.stc_rg.id
  role_definition_name = "Owner"
  principal_id         = var.admgrpid
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "stc_kv" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.stc_rg.location
  resource_group_name         = azurerm_resource_group.stc_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.admgrpid

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_postgresql_server" "postgres_server" {
  name                = var.postgresql_server_name
  location            = azurerm_resource_group.stc_rg.location
  resource_group_name = azurerm_resource_group.stc_rg.name

  administrator_login          = var.dbadmin
  administrator_login_password = var.dbpassword

  sku_name   = "B_Gen5_2"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "postgresdb" {
  name                = var.postgresdb_name
  resource_group_name = azurerm_resource_group.stc_rg.name
  server_name         = azurerm_postgresql_server.postgres_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_container_registry" "stc_acr" {
  name                = var.acrname
  resource_group_name = azurerm_resource_group.stc_rg.name
  location            = azurerm_resource_group.stc_rg.location
  sku                 = "basic"
  admin_enabled       = false
}


resource "azurerm_app_service_plan" "AppPlan" {
  name                = var.appserviceplanname
  location            = azurerm_resource_group.stc_rg.location
  resource_group_name = azurerm_resource_group.stc_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "stc_app" {
  name                = var.webapp_name
  location            = azurerm_resource_group.stc_rg.location
  resource_group_name = azurerm_resource_group.stc_rg.name
  app_service_plan_id = azurerm_app_service_plan.AppPlan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}