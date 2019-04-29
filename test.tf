terraform {
  backend "azurerm" {}
}

provider "azurerm" {}

resource "azurerm_resource_group" "resourceGroup" {
    name     = "testResourceGroup"
    location = "ukwest"
}

resource "azurerm_template_deployment" "test" {
    name                = "maps-template"
    resource_group_name = "${azurerm_resource_group.resourceGroup.name}"
    template_body       = "${file("arm/az-maps-deploy.json")}"
    deployment_mode     = "Incremental"
}
