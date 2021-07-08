provider "azurerm" {
  features {}
}

module "AD" {
  source = "./modules/AD"

  location       = var.location
  prefix         = "ttsu-wvd"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

module "storage" {
  source = "./modules/storage"

  location = var.location
  prefix   = "ttsu-wvd"
}

module "SIG" {
  source = "./modules/SIG"

  location = var.location
  prefix   = "ttsu-wvd"
}

module "log-analytics" {
  source = "./modules/log-analytics"

  location = var.location
  prefix   = "ttsu-wvd"
}

module "wvd" {
  source = "./modules/wvd"

  location = var.location
  prefix   = "ttsu-wvd"
}

# Create resource group for use with Packer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "packer" {
  name     = "packer"
  location = var.location

  tags = {
    period      = "2021-07-31"
    owner       = "ttsukui@networld.co.jp"
    costcenter  = "psg2"
  }

}