
data "azurerm_client_config" "current" {
    for_each = var.key
}
resource "azurerm_key_vault" "key" {
    for_each = var.key
  name                       = each.value.namekv
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = data.azurerm_client_config.current[each.key].tenant_id
  sku_name                   = each.value.sku_name
  soft_delete_retention_days = each.value.soft_delete_retention_days

  access_policy {
    tenant_id = data.azurerm_client_config.current[each.key].tenant_id
    object_id = data.azurerm_client_config.current[each.key].object_id

    key_permissions = [
      "Create",
      "Get",
      "List",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "user" {
    for_each = var.key
  name         = each.value.name-user
  value        = each.value.value1
  key_vault_id = azurerm_key_vault.key[each.key].id
}
resource "azurerm_key_vault_secret" "pass" {
    for_each = var.key
   name         = each.value.name-pass
  value        = each.value.value2
  key_vault_id = azurerm_key_vault.key[each.key].id
}