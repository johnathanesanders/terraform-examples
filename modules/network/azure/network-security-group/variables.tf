variable "name" {
    description = "Name of the network security group"
    type = string
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "security_rules" {
    description = "Security rules for the network security group"
    type = list(object({
        access = optional(string, "Allow")
        description = optional(string)
        destination_address_prefix = optional(string, null)
        destination_address_prefixes = optional(list(string))
        destination_application_security_group_ids = optional(list(string))
        destination_port_range = optional(string)
        destination_port_ranges = optional(list(string))
        direction = string
        name = string
        priority = number
        protocol = string
        source_address_prefix = optional(string, null)
        source_address_prefixes = optional(list(string))
        source_application_security_group_ids = optional(list(string))
        source_port_range = optional(string)
        source_port_ranges = optional(list(string))
    }))
}

variable "tags" {
    description = "Tags to be applied to the virtual network"
    type = map(string)
}