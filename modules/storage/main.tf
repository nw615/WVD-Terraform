provider "azurerm" {
  features {}
}

## Create a Resource Group for Storage
#resource "azurerm_resource_group" "rgStor" {
#  location = var.location
#  name     = "${var.prefix}-rg"
#
#  tags = var.tags
#}

## Azure Storage Accounts requires a globally unique names
## https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
## Create a File Storage Account 
resource "azurerm_storage_account" "Stor" {
  name                     = var.stor_account_name
  resource_group_name      = "${var.prefix}-rg"
  location                 = var.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"
  # tags                     = "prod"
}

resource "azurerm_storage_share" "FSShare" {
  name                 = "msix"
  storage_account_name = azurerm_storage_account.Stor.name
  depends_on           = [azurerm_storage_account.Stor]
}

resource "azurerm_storage_share" "FSShare2" {
  name                 = "fslogix"
  storage_account_name = azurerm_storage_account.Stor.name
  depends_on           = [azurerm_storage_account.Stor]
}
