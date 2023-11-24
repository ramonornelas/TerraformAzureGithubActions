#Retrieves current context data
data "azurerm_client_config" "current" {}

#Creates Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                       = "${var.prefix}${var.kvname}"
  resource_group_name        = "${var.rgname}"
  location                   = "${var.location}"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

#Creates Access Policy to Terraform SPN
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
      "Purge",
    ]
    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]
    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }
  
#Creates Access Policy for Azure Admin
    access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "your azure user object_id here"
    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
      "Purge",
    ]
    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]
    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }
}

#Creates random vmadmin password
resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "!"
}

#Creates vmadmin Secret
resource "azurerm_key_vault_secret" "adminsecret" {
  name         = "tfadminsecret"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.keyvault.id
}

#Retrieves vmadmin Secret
data "azurerm_key_vault_secret" "adminsecret" {
  name         = "tfadminsecret"
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on   = [resource.azurerm_key_vault_secret.adminsecret]
}
