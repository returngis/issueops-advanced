output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = azurerm_resource_group.rg.location
}

output "web_name" {
  value = azurerm_windows_web_app.web.name
}
