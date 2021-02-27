provider "azurerm" {
  features {}
}

module "AD" {
  source = "./modules/AD"

  location       = var.location
  prefix         = "wvd"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

module "storage" {
  source = "./modules/storage"

  location = var.location
  prefix   = "filestor"
}

module "SIG" {
  source = "./modules/SIG"

  location = var.location
  prefix   = "deployment"
}

module "log-analytics" {
  source = "./modules/log-analytics"

  location = var.location
  prefix   = "wvd"
}

module "wvd" {
  source = "./modules/wvd"

  location = var.location
  prefix   = "wvd"
}

# Create resource group for use with Packer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "packer" {
  name     = "packer"
  location = var.location
}