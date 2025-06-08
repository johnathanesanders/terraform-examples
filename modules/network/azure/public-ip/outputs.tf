output "allocation_method" {
  description = "The allocation method of the public IP address."
  value = azurerm_public_ip.public_ip.allocation_method
}

output "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP address."
  value = azurerm_public_ip.public_ip.ddos_protection_mode
}

output "ddos_protection_plan_id" {
  description = "The ID of the DDoS protection plan associated with the public IP address."
  value = azurerm_public_ip.public_ip.ddos_protection_plan_id
}

output "domain_name_label" {
  description = "The domain name label of the public IP address."
  value = azurerm_public_ip.public_ip.domain_name_label
}

output "domain_name_label_scope" {
  description = "The scope of the domain name label."
  value = azurerm_public_ip.public_ip.domain_name_label_scope
}

output "edge_zone" {
  description = "The edge zone of the public IP address."
  value = azurerm_public_ip.public_ip.edge_zone
}

output "id" {
  description = "The ID of the public IP address."
  value = azurerm_public_ip.public_ip.id
}

output "idle_timeout_in_minutes" {
  description = "The idle timeout in minutes for the public IP address."
  value = azurerm_public_ip.public_ip.idle_timeout_in_minutes
}

output "ip_address" {
    description = "The public IP address assigned."
    value = azurerm_public_ip.public_ip.ip_address
}
output "ip_tags" {
  description = "The IP tags associated with the public IP address."
  value = azurerm_public_ip.public_ip.ip_tags
}

output "ip_version" {
    description = "The IP version of the public IP address."
    value = azurerm_public_ip.public_ip.ip_version
}

output "fqdn" {
  description = "The fully qualified domain name of the public IP address."
  value = azurerm_public_ip.public_ip.fqdn
}

output "name" {
  description = "The name of the public IP address."
  value = azurerm_public_ip.public_ip.name
}

output "public_ip_prefix_id" {
  description = "The ID of the public IP prefix associated with the public IP address."
  value = azurerm_public_ip.public_ip.public_ip_prefix_id
}

output "reverse_fqdn" {
  description = "The reverse FQDN of the public IP address."
  value = azurerm_public_ip.public_ip.reverse_fqdn
}

output "sku" {
  description = "The SKU of the public IP address."
  value = azurerm_public_ip.public_ip.sku
}

output "sku_tier" {
  description = "The SKU tier of the public IP address."
  value = azurerm_public_ip.public_ip.sku_tier
}