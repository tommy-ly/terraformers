terraform {
  backend "azurerm" {}
}

provider "azurerm" {}

resource "azurerm_resource_group" "rg" {
    name = "testResourceGroup"
    location = "westus"
}

resource "azurerm_template_deployment" "test" {
    name                = "acctesttemplate-01"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    template_body = "${file("arm/az-maps-deploy.json")}"
    deployment_mode = "Incremental"
}
