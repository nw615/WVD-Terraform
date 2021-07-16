resource "azurerm_log_analytics_workspace" "lawksp" {
  name                = var.loga_name
  location            = var.location
  resource_group_name = "${var.prefix}-rg"
  sku                 = "PerGB2018"
}
