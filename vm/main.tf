resource "azurerm_linux_virtual_machine" "vmlinux" {
    for_each = var.vm
  name                = each.value.name-vm
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.blockuser.value
  admin_password =data.azurerm_key_vault_secret.blockpass.value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.data2[each.key].id,
  ]


  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}