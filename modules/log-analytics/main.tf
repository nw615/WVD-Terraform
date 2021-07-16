#resource "azurerm_resource_group" "log" {
#  name     = "${var.prefix}-rg"
#  location = var.location
#  
#  tags = var.tags
#
#  }
#
#}

resource "azurerm_log_analytics_workspace" "lawksp" {
  name                = var.loga_name
  location            = var.location
  resource_group_name = "${var.prefix}-rg"
  sku                 = "PerGB2018"
}
