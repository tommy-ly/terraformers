resource "azurerm_resource_group" "studio-rg" {
    name     = "testResourceGroup"
    location = "ukwest"
}

output "studio-rg-name" {
    value = "${azurerm_resource_group.studio-rg.name}"
}