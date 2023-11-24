output "vmadminpassword" {
  value     = data.azurerm_key_vault_secret.adminsecret.value
  sensitive = true
}
