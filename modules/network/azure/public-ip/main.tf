resource "azurerm_public_ip" "public_ip" {
    allocation_method = var.allocation_method
    ddos_protection_mode = var.ddos_protection_mode
    ddos_protection_plan_id = var.ddos_protection_plan_id
    domain_name_label = var.domain_name_label
    domain_name_label_scope = var.domain_name_label_scope
    idle_timeout_in_minutes = var.idle_timeout_in_minutes
    edge_zone = var.edge_zone
    ip_tags = var.ip_tags
    ip_version = var.ip_version
    location = var.resource_group.location
    name = var.name
    public_ip_prefix_id = var.public_ip_prefix_id
    resource_group_name = var.resource_group.name
    reverse_fqdn = var.reverse_fqdn
    sku = var.sku
    sku_tier = var.sku_tier
    tags = var.tags
    zones = var.zones
}