variable "accelerated_networking_enabled" {
    default = false
    description = "Enable accelerated networking for the network interface"
    type = bool
}

variable "auxiliary_mode" {
    default = null
    description = "Auxiliary mode for the network interface"
    nullable = true
    type = string
}

variable "auxiliary_sku" {
    default = null
    description = "Auxiliary SKU for the network interface"
    nullable = true
    type = string
}


variable "dns_servers" {
    default = null
    description = "DNS servers for the network interface"
    nullable = true
    type = list(string)
}

variable "edge_zone" {
    default = null
    description = "Edge zone for the network interface"
    nullable = true
    type = string
}

variable "internal_dns_name_label" {
    default = null
    description = "Internal DNS name label for the network interface"
    nullable = true
    type = string
}

variable "ip_configuration" {
    description = "IP configuration for the network interface"
    type = object({
        gateway_load_balancer_frontend_ip_configuration_id = optional(string)
        name = string
        primary = optional(bool, false)
        private_ip_address = optional(string)
        private_ip_address_allocation = string
        private_ip_address_version = optional(string, "IPv4")
        public_ip_address_id = optional(string)
        subnet_id = optional(string)
    })
}

variable "name" {
    description = "Name of the network interface"
    type = string
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "tags" {
    description = "Tags to be applied to the virtual network"
    type = map(string)
}