provider "azurerm"{
    features{}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "testproject-rg"
    location = "West Europe"
}

#App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
    name                = "testproject-appserviceplan"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind                = "Linux"
    reserved            = true

    sku {
        tier = "Basic"
        size = "B1"
    }
}

#Web App
resource "azurerm_app_service" "webapp" {
    name                = "testproject-stefansnoek-webapp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

    site_config {
        linux_fx_version = "NODE|14-lts"
    }
}