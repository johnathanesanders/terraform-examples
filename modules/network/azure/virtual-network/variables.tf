variable "address_space" {
    default = ["10.0.0.0/16"]
    description = "Address prefixes for the subnet"
    type = list(string)
}

variable "bgp_community" {
    default = null
    description = "BGP community for the virtual network in format <as-number>:<community-value>. The as-number segment is the Microsoft ASN, which is always 12076 for now."
    nullable = true
    type = string
}

variable "ddos_protection_plan" {
    default = null
    description = "(Optional) DDoS protection plan for the virtual network. This is a reference to an existing DDoS protection plan."
    nullable = true
    type = object({
        enable = bool
        id = string
    })
}

variable "dns_servers" {
    default = null
    description = "(Optional) DNS servers for the virtual network. This is a list of IP addresses."
    nullable = true
    type = list(string)
}

variable "edge_zone" {
    default = null
    description = "(Optional) Edge zone for the virtual network. This is a reference to an existing edge zone."
    nullable = true
    type = string
}

variable "encryption" {
    default = null
    description = "(Optional) Encryption for the virtual network. Possible values are: 'Enabled' or 'Disabled'."
    nullable = true
    type = object({
      enforcement = string
    })
    validation {
        condition = anytrue([
            try(var.encryption == null,
            contains(["AllowUnencrypted", "DropUnencrypted"], var.encryption.enforcement))
        ])
        error_message = "The encryption enforcement must be either 'AllowUnencrypted' or 'DropUnencrypted'."
    }
}

variable "flow_timeout_in_minutes" {
    default = null
    description = "(Optional) Flow timeout in minutes for the virtual network. This is a number between 1 and 60."
    nullable = true
    type = number
    validation {
        condition = anytrue([
            try(var.flow_timeout_in_minutes == null,
            alltrue([var.flow_timeout_in_minutes >= 4, var.flow_timeout_in_minutes <= 30]))
        ])
        error_message = "The flow timeout in minutes must be between 4 and 30."
    }
}

variable "name" {
    description = "Name of the virtual network"
    type = string
}

variable "private_endpoint_vnet_policies" {
    default = null
    description = "(Optional) Private endpoint policies for the virtual network. This is a reference to an existing private endpoint policy."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.private_endpoint_vnet_policies == null,
            contains(["Basic", "Disabled"], var.private_endpoint_vnet_policies))
        ])
        error_message = "The number of private endpoint policies must be less than or equal to 10."
    }
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "tags" {
    description = "Tags to be applied to the virtual network"
    nullable = true
    type = map(string)
}