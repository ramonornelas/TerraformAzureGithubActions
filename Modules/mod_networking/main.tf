#Creates Virtual Network
resource "azurerm_virtual_network" "mainvnet" {
  name                = "${var.prefix}-MainVNet"
  address_space       = ["${var.vnetaddressspace}"]
  location            = var.location
  resource_group_name = var.rgname
}

#Creates Internal Subnet to allocate IP to VM
resource "azurerm_subnet" "mainsubnet" {
  name                 = "MainSubnet"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.mainvnet.name
  address_prefixes     = ["${var.vnetsubnet}"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_network_security_group" "corensg" {
  name                = "corensg"
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "allowrdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsgtosubnet" {
  subnet_id                 = azurerm_subnet.mainsubnet.id
  network_security_group_id = azurerm_network_security_group.corensg.id
}