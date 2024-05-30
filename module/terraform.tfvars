rg = {
    rg1 = {
        name = "pkrg"
        location = "west us"
    }
}
vnet = {
    vnet1 = {
        address_space = ["10.0.0.0/16" ]
    location =  "west us"
    name = "pkvnet"
    resource_group_name = "pkrg"
    
    }
}
snet = {
    snet2 = {
         address_prefixes = [ "10.0.1.0/24" ]
    name = "subnet1"
    resource_group_name = "pkrg"
    virtual_network_name = "pkvnet"
    }
    snet3 = {
         address_prefixes = [ "10.0.2.0/24" ]
    name = "subnet2"
    resource_group_name = "pkrg"
    virtual_network_name = "pkvnet"
    }
}
bastion = {
    bastion2 = {

  name-bsnet                 = "AzureBastionSubnet"
  resource_group_name  = "pkrg"
  virtual_network_name = "pkvnet"
  address_prefixes     = ["10.0.0.0/27"]

  name-pipb              = "pkpip"
  location            = "west us"
  allocation_method   = "Static"
  sku                 = "Standard"
  name-host               = "omhost"
    name-ipb                 = "configuration"
    
  }
}
    nic = {
        nic2 = {
name-nic                = "omnic1"
name-subnet = "subnet1"
  location            =  "west us"
  resource_group_name = "pkrg"
    nicip                        = "internal"
    private_ip_address_allocation = "Dynamic"
    virtual_network_name = "pkvnet"
  }
  nic3 = {
name-nic                = "omnic2"
name-subnet ="subnet2"
  location            =  "west us"
  resource_group_name = "pkrg"
    nicip                        = "internal"
    private_ip_address_allocation = "Dynamic"
    virtual_network_name = "pkvnet"
  }
}
vm = {
  vm3 = {
  name-datanic =   "omnic1"
  name-vm               = "pk-machine2"
  resource_group_name = "pkrg"
  location            =  "west us"
  size                = "Standard_F2"
  # admin_username      = "adminuser2"
  # admin_password = "@$TJg56&JKhj"

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
   vm4 = {
  name-datanic =   "omnic2"
  name-vm               = "pk-machine1"
  resource_group_name = "pkrg"
  location            =  "west us"
  size                = "Standard_F2"
  # admin_username      = "adminuser"
  # admin_password = "$TVR&JKhj"

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
key = {
  key1 = {
    namekv                      = "mohit1devkv"
  location                   = "west us"
  resource_group_name        = "pkrg"
  sku_name                   = "premium"
  soft_delete_retention_days = 7
 name-user        = "mohituser"
  value1        = "userpk"
  name-pass        = "passcode"
  
  value2       = "#%GDgTKVIgn"
  }
}