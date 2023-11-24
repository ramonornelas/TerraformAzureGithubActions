#Defines Provider
provider "azurerm" {
  features {}
}

terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "orionscaled"
    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "azuregithubactions"
    }
  }
}