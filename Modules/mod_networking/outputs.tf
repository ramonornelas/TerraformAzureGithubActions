output "name" {
  value = azurerm_virtual_network.mainvnet.name
}
output "subnetid" {
  value = azurerm_subnet.mainsubnet.id
}