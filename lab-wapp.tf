resource "azurerm_app_service_plan" "lab_svcplan" {
  name                = "lab-svcplan"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "lab_appsvc" {
  name                = "lab-appsvc"
  location            = data.azurerm_resource_group.storage_account_rg.location
  resource_group_name = data.azurerm_resource_group.storage_account_rg.name
  app_service_plan_id = azurerm_app_service_plan.lab_svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}