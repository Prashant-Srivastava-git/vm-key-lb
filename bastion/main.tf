resource "azurerm_subnet" "bstnsnet" {
    for_each = var.bastion
  name                 = each.value.name-bsnet
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "bpip" {
    for_each = var.bastion
  name                = each.value.name-pipb
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "bastionhost" {
    for_each = var.bastion
  name                = each.value.name-host
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.name-ipb
    subnet_id            = azurerm_subnet.bstnsnet[each.key].id
    public_ip_address_id = azurerm_public_ip.bpip[each.key].id
  }
}