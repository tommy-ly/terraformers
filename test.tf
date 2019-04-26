provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
        name = "testResourceGroup"
        location = "westus"
}

data "azurerm_subscription" "current" {}

resource "azurerm_virtual_machine" "testiden" {
  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_builtin_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "testiden" {
  name               = "${azurerm_virtual_machine.testiden.name}"
  scope              = "${data.azurerm_subscription.primary.id}"
  role_definition_id = "${data.azurerm_subscription.subscription.id}${data.azurerm_builtin_role_definition.contributor.id}"
  principal_id       = "${lookup(azurerm_virtual_machine.testiden.identity[0], "principal_id")}"
}

resource "azurerm_template_deployment" "test" {
  name                = "acctesttemplate-01"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  template_body = "${file("arm/az-maps-deploy.json")}"
  deployment_mode = "Incremental"
}