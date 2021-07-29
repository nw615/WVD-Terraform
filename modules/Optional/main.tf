resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "rg-${var.prefix}"
}

#################################################
#Create Azure Automation

resource "azurerm_automation_account" "example" {
  name                = "${var.prefix}autoaccount"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name = "Basic"

  tags = var.tags

}

#Create Automation Runbook
/*
resource "azurerm_automation_runbook" "example" {
  name                    = "${var.prefix}WVDAutoScaleRunbookARMbased"
  location                = var.location
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This is an example runbook"
  runbook_type            = "PowerShellWorkflow"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
  }
}
*/

#################################################

#Create Azure Bastion
/*
resource "azurerm_subnet" "example" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = "${var.prefix}-network"
  address_prefixes     = ["10.0.3.0/27"]
}

resource "azurerm_public_ip" "example" {
  name                = "${var.prefix}bastionpip"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "${var.prefix}bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
*/