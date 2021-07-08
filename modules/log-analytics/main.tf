provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "log" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "lawksp" {
  name                = "log${random_string.random.id}"
  location            = azurerm_resource_group.log.location
  resource_group_name = azurerm_resource_group.log.name
  sku                 = "PerGB2018"
}