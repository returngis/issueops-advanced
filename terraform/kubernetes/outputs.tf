output "resource_group_name" {
  value = azurerm_resource_group.rg.name  
}

output "location" {
  value = azurerm_resource_group.rg.location
}

output "k8s_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}