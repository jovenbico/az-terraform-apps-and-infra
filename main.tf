terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

locals {
  rg_name              = "1-4a35c04a-playground-sandbox"
  storage_account_name = "1-4a35c04a-play"
}

data "azurerm_resource_group" "storage_account_rg" {
  name = local.rg_name
}