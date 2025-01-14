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
  stor_account_name = "${var.customer_prefix}stor"
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
  loga_name = "${var.customer_prefix}loga"
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

module "Firewall" {
  source ="./modules/Firewall"

  location = var.location
  prefix   = var.customer_prefix
  
}
