variable "allocation_method" {
    default = "Static"
    description = "The allocation method for the public IP address. Can be either Static or Dynamic."
    type = string
    validation {
        condition = contains(["Static", "Dynamic"], var.allocation_method)
        error_message = "The allocation method must be either Static or Dynamic."
    }
}

variable "ddos_protection_mode" {
    default = null
    description = "The DDoS protection mode for the public IP address."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.ddos_protection_mode == null,
            contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode))
        ])
        error_message = "The DDoS protection mode must be null or one of Disabled, Enabled, or VirtualNetworkInherited."
    }
}

variable "ddos_protection_plan_id" {
    default = null
    description = "The ID of the DDoS protection plan to use for the public IP address."
    nullable = true
    type = string
    validation {
      condition = anytrue([
            var.ddos_protection_plan_id == null,
            var.ddos_protection_mode == "Enabled"
      ])
      error_message = "DDOS Protection Plan ID can only be provided if DDOS Protection Mode is set to Enabled."
    }
}

variable "domain_name_label" {
    default = null
    description = "The domain name label for the public IP address. This is only applicable for Basic SKU public IP addresses."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.domain_name_label == null,
            can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]$", var.domain_name_label))
        ])
        error_message = "The domain name label must be a valid domain name."
    }
}

variable "domain_name_label_scope" {
    default = null
    description = "The scope of the domain name label. Must be one of NoReuse, ResourceGroupReuse, SubscriptionReuse, or TenantReuse."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.domain_name_label_scope == null,
            contains(["NoReuse", "ResourceGroupReuse", "SubscriptionReuse", "TenantReuse"], var.domain_name_label_scope))
        ])
        error_message = "The domain name label scope must be null or one of NoReuse, ResourceGroupReuse, SubscriptionReuse, or TenantReuse."
    }
}

variable "edge_zone" {
    default = null
    description = "The edge zone in which the public IP address should be located. This is only applicable for Standard SKU public IP addresses."
    nullable = true
    type = string
}

variable "idle_timeout_in_minutes" {
    default = null
    description = "The idle timeout in minutes for the public IP address."
    nullable = true
    type = number
    validation {
        condition = anytrue([
            try(var.idle_timeout_in_minutes == null,
            var.idle_timeout_in_minutes >= 4,
            var.idle_timeout_in_minutes <= 30)
        ])
        error_message = "The idle timeout must be null or between 4 and 30 minutes."
    }
}

variable "ip_tags" {
    default = null
    description = "A map of IP tags to be associated with the public IP address."
    nullable = true
    type = map(string)
}

variable "ip_version" {
    default = "IPv4"
    description = "The IP version of the public IP address. Can be either IPv4 or IPv6."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.ip_version == null,
            contains(["IPv4", "IPv6"], var.ip_version)
        ])
        error_message = "The IP version must be either IPv4 or IPv6."
    }
}

variable "name" {
    description = "The name of the public IP address."
    type = string
}

variable "public_ip_prefix_id" {
    default = null
    description = "The ID of the public IP prefix to use for the public IP address."
    nullable = true
    type = string
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "reverse_fqdn" {
    default = null
    description = "The reverse FQDN of the public IP address."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.reverse_fqdn == null,
            can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9](\\.[a-zA-Z]{2,})+$", var.reverse_fqdn))
        ])
        error_message = "The reverse FQDN must be a valid domain name."
    }
}

variable "sku" {
    default = "Standard"
    description = "The SKU of the public IP address. Can be either Standard or Basic."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.sku == null,
            contains(["Standard", "Basic"], var.sku)
        ])
        error_message = "The SKU must be either Standard or Basic."
    }
}

variable "sku_tier" {
    default = "Regional"
    description = "The SKU tier of the public IP address. Can be either Regional or Global."
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.sku_tier == null,
            contains(["Regional", "Global"], var.sku_tier)
        ])
        error_message = "The SKU tier must be either Regional or Global."
    }
}

variable "tags" {
    description = "Tags to be applied to the virtual network"
    type = map(string)
}

variable "zones" {
    default = null
    description = "The availability zones in which the public IP address should be located. This is only applicable for Standard SKU public IP addresses."
    nullable = true
    type = list(string)
}