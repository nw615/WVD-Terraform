resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "rg-${var.prefix}"
}

resource "azurerm_log_analytics_workspace" "lawksp" {
  name                = var.loga_name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
}
