resource "azurerm_mysql_server" "lab_mysql_server" {
  name                = "tflab-mysqlserver-1-14a35c04aplay"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name

  sku_name                     = "B_Gen5_2"
  storage_mb                   = 5120
  version                      = "5.7"
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  ssl_enforcement_enabled      = true

  administrator_login          = "mysqladminun"
  administrator_login_password = "easytologin4once!"
}

resource "azurerm_mysql_database" "lab_mysql_db" {
  name                = "exampledb"
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name
  server_name         = azurerm_mysql_server.lab_mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
