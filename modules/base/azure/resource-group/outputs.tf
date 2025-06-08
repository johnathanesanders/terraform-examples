output "id" {
    description = "ID of the resource group"
    value = azurerm_resource_group.resource_group.id
}

output "location" {
    description = "Location of the resource group"
    value = azurerm_resource_group.resource_group.location
}

output "managed_by" {
    description = "ID of the resource or application that manages this Resource Group"
    value = azurerm_resource_group.resource_group.managed_by
}

output "name" {
    description = "Name of the resource group"
    value = azurerm_resource_group.resource_group.name
}