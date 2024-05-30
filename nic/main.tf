resource "azurerm_network_interface" "nic1" {

    for_each = var.nic
  name                = each.value.name-nic
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.nicip
    subnet_id                     = data.azurerm_subnet.block1[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}