locals {
  resource_group_name = "${var.prefix}-rg"
}

resource "azurerm_resource_group" "example" {
  name     = "${local.resource_group_name}"
  location = var.location
}

module "network" {
  source              = "./modules/network"
  prefix              = "${var.prefix}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
}

module "active-directory-domain" {
  source                        = "./modules/active-directory"
  resource_group_name           = "${azurerm_resource_group.example.name}"
  location                      = "${azurerm_resource_group.example.location}"
  prefix                        = "${var.prefix}"
  subnet_id                     = "${module.network.domain_controllers_subnet_id}"
  active_directory_domain       = "${var.prefix}.com"
  active_directory_netbios_name = "${var.prefix}"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}

module "windows-client" {
  source                    = "./modules/windows-client"
  resource_group_name       = "${azurerm_resource_group.example.name}"
  location                  = "${azurerm_resource_group.example.location}"
  prefix                    = "${var.prefix}"
  subnet_id                 = "${module.network.domain_clients_subnet_id}"
  active_directory_domain   = "${var.prefix}.com"
  active_directory_username = "${var.admin_username}"
  active_directory_password = "${var.admin_password}"
  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
}

output "windows_client_public_ip" {
  value = "${module.windows-client.public_ip_address}"
}
