provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
}

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
