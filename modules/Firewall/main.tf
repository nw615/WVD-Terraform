resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "${var.prefix}-rg"
}

#Create Azure Firewall network resources
resource "azurerm_virtual_network" "example" {
  name                = "AzureFirewallVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "AzureFirewallpip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create Azure Firewall
resource "azurerm_firewall" "example" {
  name                = "${var.prefix}Firewall"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

#Create Azure Firewall Policy
resource "azurerm_firewall_policy" "example" {
  name                = "${var.prefix}FWpolicy"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

#Create Azure Firewall NAT rule collection
resource "azurerm_firewall_nat_rule_collection" "example" {
  name                = "${var.prefix}natrcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      azurerm_public_ip.example.ip_address
    ]

    translated_port = 53

    translated_address = "8.8.8.8"

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}

resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "${var.prefix}netrcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}

resource "azurerm_firewall_application_rule_collection" "example" {
  name                = "${var.prefix}apprcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    target_fqdns = [
      "*.google.com",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}
