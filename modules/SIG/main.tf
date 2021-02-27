provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.prefix}-rg"
}


## Created Shared Image Gallery
resource "azurerm_shared_image_gallery" "sig" {
  name                = "WVDTFsig"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  description         = "Shared images and things."

  tags = {
    Environment = "Demo"
    Tech        = "Terraform"
  }
}

resource "azurerm_shared_image" "example" {
  name                = "wvd-image"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"

  identifier {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "office-365"
    sku       = "20h2-evd-o365pp"
  }
}

