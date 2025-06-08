resource "azurerm_virtual_network" "virtual_network" {
    address_space = var.address_space
    bgp_community = var.bgp_community
    dynamic "ddos_protection_plan" {
        for_each = coalesce(var.ddos_protection_plan, {})
        content {
            enable = var.ddos_protection_plan.enable
            id = var.ddos_protection_plan.id
        }
    }
    dns_servers = var.dns_servers
    edge_zone = var.edge_zone
    dynamic "encryption" {
        for_each = coalesce(var.encryption, {})
        content {
            enforcement = var.encryption.enforcement
        }
    }
    flow_timeout_in_minutes = var.flow_timeout_in_minutes
    location = var.resource_group.location
    name = var.name
    private_endpoint_vnet_policies = var.private_endpoint_vnet_policies
    resource_group_name = var.resource_group.name
    tags = var.tags
}