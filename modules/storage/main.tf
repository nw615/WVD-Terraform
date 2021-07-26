resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "${var.prefix}-rg"
}

## Azure Storage Accounts requires a globally unique names
## https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
## Create a File Storage Account 
resource "azurerm_storage_account" "Stor" {
  name                     = var.stor_account_name
  resource_group_name      = azurerm_resource_group.example
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
