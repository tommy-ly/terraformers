terraform {
  backend "azurerm" {}
}

provider "azurerm" {}

module "resource-groups" {
  source = "resource_groups"
}

module "az-maps" {
  source = "az_maps"
  resource-group-name = "${module.resource-groups.studio-rg-name}"
}

