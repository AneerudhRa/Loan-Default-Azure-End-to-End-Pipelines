
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.14.2"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

provider "databricks" {

}
