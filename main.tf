#Calls mod_resourcegroup to create Core Resource Group
module "core_rg" {
  source   = "./Modules/mod_resourcegroup"
  prefix   = var.prefix
  rgname   = var.rgname
  location = var.location
}

#Calls mod_networking to create Core Vnet and Subnet
module "core_network" {
  source           = "./Modules/mod_networking"
  prefix           = var.prefix
  rgname           = module.core_rg.name
  location         = var.location
  vnetaddressspace = var.vnetaddressspace
  vnetsubnet       = var.vnetsubnet
}

#Calls mod_keyvault to create Key Vault and VM admin secret
module "core_keyvault" {
  source   = "./Modules/mod_keyvault"
  prefix   = var.prefix
  rgname   = module.core_rg.name
  location = var.location
  kvname   = "corekeyvault"
}

#Calls mod_vmworkstation to create Windows10 VM
module "core_vm" {
  source          = "./Modules/mod_vmworkstation"
  prefix          = var.prefix
  rgname          = module.core_rg.name
  location        = var.location
  vmname          = "workstation"
  vmipaddress     = "10.0.2.100"
  vmsubnet        = module.core_network.subnetid
  vmadminusername = var.vmadminusername
  vmadminpassword = module.core_keyvault.vmadminpassword
}
