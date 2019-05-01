variable "resource-group-name" {}

resource "azurerm_template_deployment" "studio-az-map" {
    name                = "maps-template"
    resource_group_name = "${var.resource-group-name}"
    template_body       = "${file("${path.module}/arm_template/az-maps-deploy.json")}"
    deployment_mode     = "Incremental"
}
