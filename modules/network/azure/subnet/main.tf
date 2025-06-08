resource "azurerm_subnet" "subnet" {
    address_prefixes = var.address_prefixes
    default_outbound_access_enabled = var.default_outbound_access_enabled
    dynamic "delegation" {
        for_each = var.delegation != null ? [var.delegation] : []
        content {
            name = delegation.name
            service_delegation {
                actions = delegation.service_delegation.actions
                name  = delegation.service_delegation.name
            }
        }
    }
    name = var.name
    private_endpoint_network_policies = var.private_endpoint_network_policies
    private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
    resource_group_name  = var.resource_group.name
    service_endpoints = var.service_endpoints
    service_endpoint_policy_ids = var.service_endpoint_policy_ids
    virtual_network_name = var.virtual_network_name
}