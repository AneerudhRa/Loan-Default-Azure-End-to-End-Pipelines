data "azurerm_client_config" "current" {}

##------------RESOURCE GROUP----------------##

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

##------------DATA FACTORY----------------##

resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_role_assignment.sbdc_current_user
  ]
}

# In datafactory, still you need to download and install the provisioned Self hosted integration runtime
resource "azurerm_data_factory_integration_runtime_self_hosted" "shir" {
  name            = var.self_hosted_integration_runtime_name
  data_factory_id = azurerm_data_factory.adf.id
}

resource "azurerm_data_factory_linked_service_sql_server" "example" {
  name                     = var.adf_ssms_onprem_linked_service
  data_factory_id          = azurerm_data_factory.adf.id
  integration_runtime_name = azurerm_data_factory_integration_runtime_self_hosted.shir.name
  connection_string        = "Integrated Security=False;Data Source=<servername>;Initial Catalog=<databasename>;User ID=<username>;Password=<password>"
}


# resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "adls_gen2_with_mi" {
#   name            = var.adf_datalake_linked_service
#   data_factory_id = azurerm_data_factory.adf.id

#   url             = "https://${azurerm_storage_account.datalake.name}.dfs.core.windows.net"

#   use_managed_identity = true
# }

# resource "azurerm_role_assignment" "data_factory_storage_contributor" {
#   scope                = azurerm_storage_account.datalake.id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = azurerm_data_factory.adf.identity[0].principal_id

#   depends_on = [azurerm_data_factory.adf]
# }



##------------DATA LAKE GEN 2----------------##

resource "azurerm_storage_account" "datalake" {
  name                     = var.datalake_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_container" "container1" {
  name                  = var.storage_container_1
  storage_account_name  = azurerm_storage_account.datalake.name
  container_access_type = "private"
}


resource "azurerm_storage_data_lake_gen2_filesystem" "container2" {
  name               = var.storage_container_2
  storage_account_id = azurerm_storage_account.datalake.id
  depends_on = [
    azurerm_role_assignment.sbdc_current_user
  ]
}

resource "azurerm_role_assignment" "sbdc_current_user" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "sbdc_syn_ws" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_synapse_workspace.synapse.identity[0].principal_id
}


##------------DATA BRICKS----------------##

resource "azurerm_databricks_workspace" "databricks" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.databricks_workspace_sku
}







##------------SYNAPSE ANALYTICS----------------##

resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.container2.id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_login_password
  managed_virtual_network_enabled      = true

  aad_admin {
    login     = var.aad_admin_login
    object_id = var.object_id
    tenant_id = var.tenant_id
  }

  identity {
    type = "SystemAssigned"
  }

}

# resource "azurerm_synapse_sql_pool" "example" {
#   name                 = var.synapse_sql_pool_name
#   synapse_workspace_id = azurerm_synapse_workspace.synapse.id
#   sku_name             = var.synapse_sql_pool_sku_name
#   create_mode          = "Default"
# }

