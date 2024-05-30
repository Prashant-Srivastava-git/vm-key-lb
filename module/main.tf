module "resource" {
  source = "../resource"
  rg = var.rg
  
}
module "virtual_network" {
  source = "../vnet"
  vnet = var.vnet
  depends_on = [ module.resource ]
}
module "subnet" {
  source = "../subnet"
  snet = var.snet
  depends_on = [ module.virtual_network ]
  
}
module "bastion1" {
  source = "../bastion"
  bastion = var.bastion
  depends_on = [ module.resource ]
}
module "nic11" {
  source = "../nic"
  nic = var.nic
  depends_on = [ module.subnet ]
  
}
module "vmnew" {
  source = "../vm"
  vm = var.vm
  depends_on = [ module.key_vault ]
  
}
module "key_vault" {
  source = "../key"
key = var.key  
depends_on = [ module.resource ]
}