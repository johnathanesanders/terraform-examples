output "id" {
  description = "The ID of the network security group."
  value = azurerm_network_security_group.network_security_group.id
}

output "location" {
  description = "The location of the network security group."
  value = azurerm_network_security_group.network_security_group.location
}

output "name" {
  description = "The name of the network security group."
  value = azurerm_network_security_group.network_security_group.name
}

output "resource_group_name" {
  description = "The name of the resource group in which the network security group is located."
  value = azurerm_network_security_group.network_security_group.resource_group_name
}

output "security_rule" {
  description = "The security rules associated with the network security group."
  value = azurerm_network_security_group.network_security_group.security_rule
}