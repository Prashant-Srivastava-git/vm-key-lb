data "azurerm_subnet" "block1" {
    for_each = var.nic
  name                 = each.value.name-subnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
