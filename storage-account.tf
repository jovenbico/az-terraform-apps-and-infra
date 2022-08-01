resource "azurerm_storage_account" "lab_storage_account" {
  name                     = local.storage_account_name
  resource_group_name      = data.azurerm_resource_group.storage_account_rg.name
  location                 = data.azurerm_resource_group.storage_account_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Storage"
    CreatedBy   = "Admin"
  }
}