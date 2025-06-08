output "address_prefixes" {
    description = "Address prefixes for the subnet"
    value = azurerm_subnet.subnet.address_prefixes
}

output "default_outbound_access_enabled" {
    description = "Default outbound access enabled for the subnet"
    value = azurerm_subnet.subnet.default_outbound_access_enabled
}

output "delegation" {
    description = "Delegation for the subnet"
    value = azurerm_subnet.subnet.delegation
}

output "id" {
    description = "ID of the subnet"
    value = azurerm_subnet.subnet.id
}

output "name" {
    description = "Name of the subnet"
    value = azurerm_subnet.subnet.name
}

output "private_endpoint_network_policies" {
    description = "Private endpoint network policies for the subnet"
    value = azurerm_subnet.subnet.private_endpoint_network_policies
}

output "private_link_service_network_policies_enabled" {
    description = "Private link service network policies enabled for the subnet"
    value = azurerm_subnet.subnet.private_link_service_network_policies_enabled
}

output "resource_group_name" {
    description = "Name of the resource group"
    value = azurerm_subnet.subnet.resource_group_name
}

output "service_endpoints" {
    description = "Service endpoints for the subnet"
    value = azurerm_subnet.subnet.service_endpoints
}

output "service_endpoint_policy_ids" {
    description = "Service endpoint policy IDs for the subnet"
    value = azurerm_subnet.subnet.service_endpoint_policy_ids
}

output "virtual_network_name" {
    description = "Name of the virtual network"
    value = azurerm_subnet.subnet.virtual_network_name
}