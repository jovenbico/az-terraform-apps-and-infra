#Deploy Public IP
resource "azurerm_public_ip" "lab_pip" {
  name                = "lab-pip"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

#Create NIC
resource "azurerm_network_interface" "lab_nic" {
  name                = "lab-nic"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.lab_vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lab_pip.id
  }
}

# #Create Boot Diagnostic Account
# resource "azurerm_storage_account" "sa" {
#   name                     = "Enter Name for Diagnostic Account"
#   resource_group_name      = "<RESOURCE_GROUP_NAME>"
#   location                 = "East US"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "Boot Diagnostic Storage"
#     CreatedBy   = "Admin"
#   }
# }

#Create Virtual Machine
resource "azurerm_virtual_machine" "lab_vm" {
  name                             = "lab-vm"
  location                         = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name              = data.azurerm_resource_group.storage_account_rg.name
  network_interface_ids            = [azurerm_network_interface.lab_nic.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    disk_size_gb      = "128"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "lab-vm"
    admin_username = "vmadmin"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.lab.primary_blob_endpoint
  }
}
