provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id

}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure App Service Plan
resource "azurerm_service_plan" "plan" {

  name                = "${var.web_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type = "Windows"

  sku_name = "F1"
}

# Create Web App
resource "azurerm_windows_web_app" "web" {

  name                = var.web_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  service_plan_id = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      current_stack  = "dotnetcore"
      dotnet_version = "v7.0"
    }
  }  
}
