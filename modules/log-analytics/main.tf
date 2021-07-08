provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "log" {
  name     = "${var.prefix}-resources"
  location = var.location
  
  tags = {
    period      = "2021-07-31"
    owner       = "ttsukui@networld.co.jp"
    costcenter  = "psg2"
  }

}

resource "azurerm_log_analytics_workspace" "lawksp" {
  name                = "log${random_string.random.id}"
  location            = azurerm_resource_group.log.location
  resource_group_name = azurerm_resource_group.log.name
  sku                 = "PerGB2018"
}