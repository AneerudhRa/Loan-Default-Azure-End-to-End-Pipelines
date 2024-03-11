variable "aad_admin_login" {
  description = "Name of the AAD User"
  type        = string

}
variable "object_id" {
  description = "Object ID"
  type        = string

}
variable "tenant_id" {
  description = "Tenant ID"
  type        = string

}


##------------RESOURCE GROUP----------------##

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "data-engineering-rg"
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
  default     = "East US"
}

##------------DATA FACTORY----------------##

variable "data_factory_name" {
  description = "Name of the Azure Data Factory"
  type        = string
  default     = "datafactory-dataeng-project"
}

variable "self_hosted_integration_runtime_name" {
  description = "Name of the Integration runtime"
  type        = string

}

variable "adf_ssms_onprem_linked_service" {
  description = "Name of the Azure Data Factory to SSMS Onprem Linked Service"
  type        = string

}
variable "adf_datalake_linked_service" {
  description = "Name of the Azure Data Factory to Datalake Linked Service"
  type        = string

}


##------------DATA LAKE GEN 2----------------##

variable "datalake_storage_account_name" {
  description = "Name of the Azure Data Lake Storage Gen2 account"
  type        = string
  default     = "examplestorageacc"
}

variable "storage_container_1" {
  description = "Names of the Azure Storage containers"
  type        = string

}

variable "storage_container_2" {
  description = "Names of the Azure Storage containers"
  type        = string

}


##------------DATA BRICKS----------------##

variable "databricks_workspace_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
  default     = "databricks-workspace"
}

variable "databricks_workspace_sku" {
  description = "SKU of the Azure Databricks workspace"
  type        = string
  default     = "standard"
}







##------------SYNAPSE ANALYTICS----------------##

variable "synapse_workspace_name" {
  description = "Name of the Azure Synapse workspace"
  type        = string
  default     = "synapseworkspace123"
}

variable "sql_administrator_login" {
  description = "SQL administrator login name for Azure Synapse Analytics"
  type        = string
  default     = "sqladminuser"
}

variable "sql_administrator_login_password" {
  description = "SQL administrator login password for Azure Synapse Analytics"
  type        = string
  default     = "H@Sh1CoR3!"
}

variable "synapse_sql_pool_name" {
  description = "Name of the Azure Synapse SQL pool"
  type        = string
  default     = "example_sql_pool1000123"
}

variable "synapse_sql_pool_sku_name" {
  description = "SKU name for the Azure Synapse SQL pool"
  type        = string
  default     = "DW100c"
}











