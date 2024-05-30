data "azurerm_network_interface" "data2" {
    for_each = var.vm
  name                = each.value.name-datanic
  resource_group_name = each.value.resource_group_name
}
data "azurerm_key_vault" "keyidblock" {
  name                = "mohit1devkv"
  resource_group_name = "pkrg"
}

data "azurerm_key_vault_secret" "blockuser" {
  
  name         = "mohituser"
  key_vault_id = data.azurerm_key_vault.keyidblock.id
}
data "azurerm_key_vault_secret" "blockpass" {
  name         = "passcode"
  key_vault_id =data.azurerm_key_vault.keyidblock.id
}
