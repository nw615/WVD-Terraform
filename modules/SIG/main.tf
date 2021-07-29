resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "rg-${var.prefix}"
}

## Created Shared Image Gallery
resource "azurerm_shared_image_gallery" "sig" {
  name                = "WVDTFsig"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  description         = "Shared images and things."

  tags = var.tags

}

resource "azurerm_shared_image" "example" {
  name                = "wvd-image"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = "rg-${var.prefix}"
  location            = var.location
  os_type             = "Windows"

  identifier {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "office-365"
    sku       = "20h2-evd-o365pp"
  }
}
  