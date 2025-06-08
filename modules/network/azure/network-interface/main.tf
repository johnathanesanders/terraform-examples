resource "azurerm_network_interface" "network_interface" {
    accelerated_networking_enabled = var.accelerated_networking_enabled
    auxiliary_mode = var.auxiliary_mode
    auxiliary_sku = var.auxiliary_sku
    dns_servers = var.dns_servers
    edge_zone = var.edge_zone
    internal_dns_name_label = var.internal_dns_name_label
    ip_configuration {
        gateway_load_balancer_frontend_ip_configuration_id = var.ip_configuration.gateway_load_balancer_frontend_ip_configuration_id
        name = var.ip_configuration.name
        primary = var.ip_configuration.primary
        private_ip_address = var.ip_configuration.private_ip_address
        private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
        private_ip_address_version = var.ip_configuration.private_ip_address_version
        public_ip_address_id = var.ip_configuration.public_ip_address_id
        subnet_id = var.ip_configuration.subnet_id
    }
    location = var.resource_group.location
    name = var.name
    resource_group_name = var.resource_group.name
    tags = var.tags
}