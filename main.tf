provider "azurerm" {
  features {}
}

module "AD" {
  source = "./modules/AD"

  location       = var.location
  prefix         = var.customer_prefix
  admin_username = var.admin_username
  admin_password = var.admin_password
  tags           = var.tags
}

module "storage" {
  source = "./modules/storage"

  location          = var.location
  prefix            = var.customer_prefix
  stor_account_name = var.customer_stor_account_name
}

module "SIG" {
  source = "./modules/SIG"

  location = var.location
  prefix   = var.customer_prefix
  tags     = var.tags
}

module "log-analytics" {
  source = "./modules/log-analytics"

  location  = var.location
  prefix    = var.customer_prefix
  loga_name = var.customer_loga_name
}

module "wvd" {
  source = "./modules/wvd"

  location = var.location
  prefix   = var.customer_prefix
}

module "Optional" {
  source = "./modules/Optional"

  location = var.location
  prefix   = var.customer_prefix
  tags     = var.tags
}


# Create resource group for use with Packer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "packer" {
  name     = "ttsu-packer"
  location = var.location
  tags = var.tags
  
}