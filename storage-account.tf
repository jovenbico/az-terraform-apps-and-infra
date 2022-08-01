resource "azurerm_storage_account" "lab" {
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

#########################################
## Deploy File Share and Blobe storage ##
#########################################
resource "azurerm_storage_container" "lab" {
  name                  = "blobcontainer4lab"
  storage_account_name  = azurerm_storage_account.lab.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "lab" {
  name                   = "TerraformBlob"
  storage_account_name   = azurerm_storage_account.lab.name
  storage_container_name = azurerm_storage_container.lab.name
  type                   = "Block"
}
resource "azurerm_storage_share" "lab" {
  name                 = "terraformshare"
  storage_account_name = azurerm_storage_account.lab.name
  quota                = 50
}