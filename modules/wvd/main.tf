provider "azurerm" {
  features {}
}

##Create WVD Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "time_rotating" "wvd_token" {
  rotation_days = 30
}

#Create WVD workspace
resource "azurerm_virtual_desktop_workspace" "example" {
  name                = "${var.prefix}workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  friendly_name       = "WVD Workspace"
  description         = "A description of my workspace"
}

# Create WVD host pool
resource "azurerm_virtual_desktop_host_pool" "example" {
  resource_group_name      = azurerm_resource_group.rg.name
  name                     = "${var.prefix}hostpool"
  location                 = azurerm_resource_group.rg.location
  validate_environment     = false
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "BreadthFirst" #[BreadthFirst DepthFirst]
  friendly_name            = "WVDHostPool"
  tags = {
    "image" = "february"
  }

  registration_info {
    expiration_date = time_rotating.wvd_token.rotation_rfc3339
  }
}

# Create WVD DAG
resource "azurerm_virtual_desktop_application_group" "example" {
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.example.id
  location            = azurerm_resource_group.rg.location
  type                = "Desktop"
  name                = "${var.prefix}dag"
  friendly_name       = "WVDAppGroup"
  description         = "WVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.example]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "example" {
  application_group_id = azurerm_virtual_desktop_application_group.example.id
  workspace_id         = azurerm_virtual_desktop_workspace.example.id
}

