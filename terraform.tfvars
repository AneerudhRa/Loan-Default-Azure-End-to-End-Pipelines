## Add your object id and tenant id from Azure Active Directory / Entra
## Better to use keyvault to access sensitive keys like these

aad_admin_login = ""
object_id       = ""
tenant_id       = ""



##------------RESOURCE GROUP----------------##

resource_group_name = "data-engineering-endtoend-proj-rg"
location            = "East US"

##------------DATA FACTORY----------------##

data_factory_name                    = "datafactory-dataeng-project"
self_hosted_integration_runtime_name = "SHIR003"
adf_ssms_onprem_linked_service       = "Onprem SSMS ADF"
adf_datalake_linked_service          = "ADF Datalake linkage"

##------------DATA LAKE GEN 2----------------##

datalake_storage_account_name = "datalake0012storage"
storage_container_1           = "raw-data"
storage_container_2           = "cleaned-data"


##------------DATA BRICKS----------------##

databricks_workspace_name = "databricks-workspace1"
databricks_workspace_sku  = "premium"



##------------SYNAPSE ANALYTICS----------------##

synapse_workspace_name           = "synapseworkspace12rgrg3"
sql_administrator_login          = "sqladminuser"
sql_administrator_login_password = "H@Sh1CoR3!"
synapse_sql_pool_name            = "example_sql_pool1000123"
synapse_sql_pool_sku_name        = "DW100c"






