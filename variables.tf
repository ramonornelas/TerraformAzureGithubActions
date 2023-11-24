#Defines Variables

#Resource Group Section
variable "prefix" {
  description = "Enter the prefix for naming convention"
  default     = "tf"
}
variable "rgname" {
  description = "Enter the resource group name"
  default     = "AzureLab"
}
variable "location" {
  description = "Enter the location"
  default     = "eastus"
}

#Networking Section
variable "vnetaddressspace" {
  description = "Enter the address space for the Vnet in CIDR format"
  default     = "10.0.0.0/16"
}
variable "vnetsubnet" {
  description = "Enter CIDR for the main subnet"
  default     = "10.0.2.0/24"
}

#VM Admin User Section
variable "vmadminusername" {
  description = "Enter administrator username for VM"
  default     = "tfadmin"
}
