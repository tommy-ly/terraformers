provider "azurerm" {
}

data "azuread_subscription" "current" {}

resource "azurerm_resource_group" "rg" {
    name = "testResourceGroup"
    location = "westus"
    identity = {
      type = "SystemAssigned"
    }
}

data "azuread_builtin_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_template_deployment" "test" {
    name                = "acctesttemplate-01"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    template_body = "${file("arm/az-maps-deploy.json")}"
    deployment_mode = "Incremental"
}

resource "azuread_role_assignment" "test" {
  name               = "${azuread_virtual_machine.test.name}"
  scope              = "${data.azuread_subscription.primary.id}"
  role_definition_id = "${data.azuread_subscription.subscription.id}${data.azuread_builtin_role_definition.contributor.id}"
  principal_id       = "${lookup(azuread_virtual_machine.test.identity[0], "principal_id")}"
}