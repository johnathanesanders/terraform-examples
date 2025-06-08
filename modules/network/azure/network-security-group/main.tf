resource "azurerm_network_security_group" "network_security_group" {
    location = var.resource_group.location
    name = var.name
    resource_group_name = var.resource_group.name
    dynamic "security_rule" {
        for_each = var.security_rules
        content {
            access = security_rule.value["access"]
            description = security_rule.value["description"]
            destination_address_prefix = security_rule.value["destination_address_prefix"] != null ? security_rule.value["destination_address_prefix"] : null
            destination_address_prefixes = security_rule.value["destination_address_prefixes"] != null ? security_rule.value["destination_address_prefixes"] : null
            destination_application_security_group_ids = security_rule.value["destination_application_security_group_ids"]
            destination_port_range = security_rule.value["destination_port_range"] != null ? security_rule.value["destination_port_range"] : null
            destination_port_ranges = security_rule.value["destination_port_ranges"] != null ? security_rule.value["destination_port_ranges"] : null
            direction = security_rule.value["direction"]
            name = security_rule.value["name"]
            priority = security_rule.value["priority"]
            protocol = security_rule.value["protocol"]
            source_address_prefix = security_rule.value["source_address_prefix"] != null ? security_rule.value["source_address_prefix"] : null
            source_address_prefixes = security_rule.value["source_address_prefixes"] != null ? security_rule.value["source_address_prefixes"] : null
            source_application_security_group_ids = security_rule.value["source_application_security_group_ids"]
            source_port_range = security_rule.value["source_port_range"] != null ? security_rule.value["source_port_range"] : null
            source_port_ranges = security_rule.value["source_port_ranges"] != null ? security_rule.value["source_port_ranges"] : null
        }
    }
    tags = var.tags
}