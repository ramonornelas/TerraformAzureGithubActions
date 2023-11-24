resource "azurerm_resource_group" "mainrg" {
  name     = "${var.prefix}-${var.rgname}"
  location = var.location
}