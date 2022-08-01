resource "azurerm_network_security_group" "lab_nsg" {
  name                = "lab-nsg"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name

  tags = {
    environment = "Terraform Networking"
  }
}

resource "azurerm_network_security_rule" "lab_nsg_web80_in" {
  name                        = "web-80"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.storage_account_rg.name
  network_security_group_name = azurerm_network_security_group.lab_nsg.name
}

resource "azurerm_network_security_rule" "lab_nsg_web8080_in" {
  name                        = "web-8080"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "8080"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.storage_account_rg.name
  network_security_group_name = azurerm_network_security_group.lab_nsg.name
}

resource "azurerm_network_security_rule" "lab_nsg_web80_out" {
  name                        = "web-80-out"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.storage_account_rg.name
  network_security_group_name = azurerm_network_security_group.lab_nsg.name
}
resource "azurerm_network_security_rule" "lab_nsg_ssh" {
  name                        = "SSH"
  priority                    = 1100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.storage_account_rg.name
  network_security_group_name = azurerm_network_security_group.lab_nsg.name
}

  