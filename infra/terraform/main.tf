# Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "testproject-rg"
    location = "West Europe"
}

#App Service Plan
resource "azurerm_service_plan" "asp" {
    name                = "testproject-asp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    os_type             = "Linux"
    sku_name            = "B1"
}

#Web App
resource "azurerm_app_service" "webapp" {
    name                = "testproject-stefansnoek-webapp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_service_plan.asp.id

    site_config {
        linux_fx_version = "NODE|18-lts"
    }

    logs {
        detailed_error_messages_enabled = true
        application_logs{
            file_system_level = "Verbose"
        }    
    }
}