resource "azurerm_public_ip" "lbpip" {
  name                = "PublicIPForLB"
  location            = "west us"
  resource_group_name = "omrg"
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "azurelb" {
  name                = "pkLoadBalancer"
  location            = "west us"
  resource_group_name = "omrg"
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpip.id
    
  }
}
resource "azurerm_lb_backend_address_pool" "backpool" {
  loadbalancer_id = azurerm_lb.azurelb.id
  name            = "BackEndAddressPool"
}
data "azurerm_network_interface" "nic1" {
  name                = "omnic1"
  resource_group_name = "omrg"
}
data "azurerm_network_interface" "nic2" {
  name                = "omnic2"
  resource_group_name = "omrg"
}
resource "azurerm_network_interface_backend_address_pool_association" "nibapa1" {
  network_interface_id    = data.azurerm_network_interface.nic1.id
  ip_configuration_name   = data.azurerm_network_interface.nic1.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backpool.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nibapa2" {
  network_interface_id    = data.azurerm_network_interface.nic2.id
  ip_configuration_name   = data.azurerm_network_interface.nic2.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backpool.id
}
resource "azurerm_lb_probe" "lbprobe" {
  loadbalancer_id = azurerm_lb.azurelb.id
  name            = "ssh-running-probe"
  port            = 80
}
resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.azurelb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backpool.id]
  probe_id = azurerm_lb_probe.lbprobe.id
}