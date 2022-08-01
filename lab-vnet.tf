# Create virtual network
resource "azurerm_virtual_network" "lab_vnet" {
  name                = "lab_vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name
  location            = data.azurerm_resource_group.storage_account_rg.location

  tags = {
    environment = "Terraform Networking"
  }
}

# Create subnet
resource "azurerm_subnet" "lab_vnet_subnet" {
  name                 = "LabSubnet"
  resource_group_name  = data.azurerm_resource_group.storage_account_rg.name
  virtual_network_name = azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "lab_vnet_subnet2" {
  name                 = "LabSubnet2"
  resource_group_name  = data.azurerm_resource_group.storage_account_rg.name
  virtual_network_name = azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}