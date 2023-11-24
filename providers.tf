#Defines Provider
provider "azurerm" {
    features {}
}

#Sends tfstate to azure blob
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-AzureLab-tfState-RG"
    storage_account_name = "azurelabtfstatesa"
    container_name       = "azurelabtfstatecn"
    key                  = "terraformazuredemo.tfstate"
  }
}
