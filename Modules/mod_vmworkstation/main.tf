#Creates Public IP
resource "azurerm_public_ip" "mainpip" {
  name                = "${var.prefix}-${var.vmname}-Pip"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
  allocation_method   = "Static"
}

#Creates Network Interface and assigns private and public IP's
resource "azurerm_network_interface" "mainnic" {
  name                = "${var.prefix}-${var.vmname}-NIC"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"

  ip_configuration {
    name                          = "MainNICConfiguration"
    subnet_id                     = "${var.vmsubnet}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.vmipaddress}"
    public_ip_address_id          = "${azurerm_public_ip.mainpip.id}"
  }
}

#Creates VM
resource "azurerm_virtual_machine" "mainvm" {
  name                  = "${var.prefix}-${var.vmname}"
  location              = "${var.location}"
  resource_group_name   = "${var.rgname}"
  network_interface_ids = ["${azurerm_network_interface.mainnic.id}"]
  vm_size               = "Standard_B1s"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-10"
    sku       = "19h2-pro-g2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-${var.vmname}-OSdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.vmname}"
    admin_username = "${var.vmadminusername}"
    admin_password = "${var.vmadminpassword}"
  }
  os_profile_windows_config {
    provision_vm_agent = "true"
  }
}