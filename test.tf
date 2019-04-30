terraform {
  backend "azurerm" {}
}

provider "azurerm" {}

resource "azurerm_storage_account" "sa" {
    name          = "testResourceGroup"
    account_kind  = "BlobStorage"
    account_tier  = "Standard"
}

resource "azurerm_storage_container" "test" {
  name                  = "watdis"
  resource_group_name   = "testResourceGroup"
  storage_account_name  = "horselizard"
  container_access_type = "private"
}

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
