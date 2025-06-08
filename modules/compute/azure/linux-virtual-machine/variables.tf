variable "additional_capabilities" {
    default = null
    description = "Additional capabilities for the virtual machine"
    nullable = true
    type = object({
        hibernation_enabled = optional(bool)
        ultra_ssd_enabled = optional(bool, false)
    })
}

variable "admin" {
    description = "Admin user for the virtual machine"
    type = object({
        public_key = optional(string)
        public_key_path = optional(string)
        username = string
    })
}

variable "allow_extension_operations" {
    default = true
    description = "Allow extension operations on the virtual machine"
    nullable = true
    type = bool
    validation {
        condition = anytrue([
            alltrue([var.allow_extension_operations == null]),
            alltrue([var.allow_extension_operations]), 
            alltrue([!var.provision_vm_agent, !var.allow_extension_operations])
        ])
        error_message = "If Allow Extension Operations is set to false, then Provision VM Agent must also be set to false."
    }
}

variable "availability_set_id" {
    default = null
    description = "ID of the availability set to associate with the virtual machine"
    nullable = true
    type = string
}

variable "boot_diagnostics" {
    default = null
    description = "Boot diagnostics settings for the virtual machine"
    nullable = true
    type = object({
        storage_account_uri = string
    })
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
    default = false
    description = "Bypass platform safety checks on user schedule enabled"
    nullable = true
    type = bool
    validation {
        condition = (var.bypass_platform_safety_checks_on_user_schedule_enabled == true && 
            var.patch_mode == "AutomaticByPlatform") || var.bypass_platform_safety_checks_on_user_schedule_enabled == false
        error_message = "Bypass platform safety checks on user schedule enabled can only be set to true when patch mode is set to AutomaticByPlatform."
    }
}

variable "capacity_reservation_group_id" {
    default = null
    description = "ID of the capacity reservation group to associate with the virtual machine"
    nullable = true
    type = string
}

variable "computer_name" {
    default = null
    description = "Computer name (Hostname) for the virtual machine. If null, defaults to the name of the virtual machine."
    nullable = true
    type = string
}

variable "custom_data" {
    default = null
    description = "Custom data to be passed to the virtual machine. Must be in Base64 format."
    nullable = true
    type = string
}

variable "dedicated_host_id" {
    default = null
    description = "ID of the dedicated host to associate with the virtual machine"
    nullable = true
    type = string
}

variable "dedicated_host_group_id" {
    default = null
    description = "ID of the dedicated host group to associate with the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            alltrue([var.dedicated_host_id == null, var.dedicated_host_group_id == null]),
            alltrue([var.dedicated_host_id != null, var.dedicated_host_group_id == null]),
            alltrue([var.dedicated_host_id == null && var.dedicated_host_group_id != null])
        ])
        error_message = "Either dedicated_host_id or dedicated_host_group_id can be provided, but not both."
    }
}

variable "disk_controller_type" {
    default = null
    description = "Disk controller type for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.disk_controller_type == null,
            var.disk_controller_type == "SCSI",
            var.disk_controller_type == "NVMe"
        ])
        error_message = "If disk controller type is provided, it must be either SCSI or NVMe."
    }
}

variable "edge_zone" {
    default = null
    description = "Edge zone for the virtual machine"
    nullable = true
    type = string
}

variable "encryption_at_host_enabled" {
    default = null
    description = "Enable encryption at host for the virtual machine"
    nullable = true
    type = bool
}

variable "eviction_policy" {
    default = null
    description = "Eviction policy for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            var.eviction_policy == null,
            contains([
                "Deallocate", "Delete"
            ], coalesce(var.eviction_policy, "NONE"))
        ])
        error_message = "Eviction policy must be one of Deallocate or Delete."
    }
}

variable "extensions_time_budget" {
    default = "PT1H30M"
    description = "Time budget for extensions to be applied to the virtual machine. The duration should be between 15 minutes and 120 minutes (inclusive) and specified in ISO 8601 format. Defaults to PT1H30M."
    nullable = true
    type = string
}

variable "gallery_application" {
    default = null
    description = "Gallery application for the virtual machine"
    nullable = true
    type = object({
      automatic_upgrade_enabled = optional(bool, false)
      configuration_blob_uri = optional(string)
      order = optional(number, 0)
      tag = optional(string)
      treat_failure_as_deployment_failure_enabled = optional(bool, false)
      version_id = string
    })
}

variable "identity" {
    default = null
    description = "Identity settings for the virtual machine"
    nullable = true
    type = object({
        identity_ids = optional(list(string))
        type = string
    })
    validation {
        condition = anytrue([
            var.identity == null,
            alltrue([
                try(var.identity != null,
                var.identity.type != null,
                contains([
                    "SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"
                ], var.identity.type))
            ])
        ])
        error_message = "Identity type must either be null or one of 'SystemAssigned', 'UserAssigned' or 'System Assigned, UserAssigned' (to enable both)."
    }
}

variable "license_type" {
    default = null
    description = "License type for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.license_type == null,
            contains([
                "RHEL_BYOS", "RHEL_BASE", "RHEL_EUS", "RHEL_SAPAPPS", "RHEL_SAPHA", "RHEL_BASESAPAPPS", "RHEL_BASESAPHA", "SLES_BYOS", "SLES_SAP", "SLES_HPC", "UBUNTU_PRO"
            ], var.license_type))
        ])
        error_message = "License type must be one of RHEL_BYOS, RHEL_BASE, RHEL_EUS, RHEL_SAPAPPS, RHEL_SAPHA, RHEL_BASESAPAPPS, RHEL_BASESAPHA, SLES_BYOS, SLES_SAP, SLES_HPC, or UBUNTU_PRO."
    }
}

variable "max_bid_price" {
    default = null
    description = "Maximum bid price for the virtual machine in the capacity reservation group. Set to -1 for pay-as-you-go pricing."
    nullable = true
    type = number
    validation {
        condition = anytrue([(var.max_bid_price != null && var.priority == "Spot"), var.max_bid_price == null])
        error_message = "Max bid price can only be set if priority is set to Spot. Defaults to -1 if Spot priority."
    }
}

variable "name" {
    description = "Name of the virtual machine"
    type = string
}

variable "network_interface_ids" {
    description = "List of network interface IDs to associate with the virtual machine"
    type = list(string)
}

variable "os_disk" {
    description = "OS disk settings for the virtual machine"
    type = object({
        caching = string
        diff_disk_settings = optional(object({
            option = optional(string, "Local")
            placement = optional(string, "CacheDisk")
        }))
        disk_encryption_set_id = optional(string)
        disk_size_gb = optional(number)
        name = optional(string)
        secure_vm_disk_encryption_set_id = optional(string)
        security_encryption_type = optional(string)
        storage_account_type = string
        write_accelerator_enabled = optional(bool, false)
    })
    validation {
        condition = contains([
            "Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"],
            var.os_disk.storage_account_type
        )
        error_message = "Storage Account Type must be one of Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, or Premium_ZRS."
    }
    validation {
        condition = contains([
            "None", "ReadOnly", "ReadWrite"
        ], var.os_disk.caching)
        error_message = "Caching must be one of None, ReadOnly, or ReadWrite."
    }
    validation {
        condition = anytrue([
            var.os_disk.diff_disk_settings == null,
            alltrue([
                var.os_disk.diff_disk_settings != null,
                var.os_disk.caching == "ReadOnly"
            ])
        ])
        error_message = "Diff Disk Settings can only be used with ReadOnly caching."
    }
    validation {
        condition = anytrue([
            try(var.os_disk.security_encryption_type == null,
            contains([
                "DiskWithVMGuestState", "VMGuestStateOnly"
            ], var.os_disk.security_encryption_type))
        ])
        error_message = "Security Encryption Type must be one of DiskWithVMGuestState or VMGuestStateOnly."
    }
    validation {
        condition = anytrue([
            alltrue([
                var.os_disk.disk_encryption_set_id == null,
                var.os_disk.secure_vm_disk_encryption_set_id == null
            ]),
            alltrue([
                var.os_disk.disk_encryption_set_id != null,
                var.os_disk.secure_vm_disk_encryption_set_id == null
            ]),
            alltrue([
                var.os_disk.disk_encryption_set_id == null, 
                var.os_disk.secure_vm_disk_encryption_set_id != null
            ])
        ])
        error_message = "Either disk_encryption_set_id or secure_vm_disk_encryption_set_id can be provided, but not both."
    }
    validation {
        condition = anytrue([
            var.os_disk.secure_vm_disk_encryption_set_id == null,
            alltrue([
                var.os_disk.secure_vm_disk_encryption_set_id != null,
                var.os_disk.security_encryption_type == "DiskWithVMGuestState"
            ])
        ])
        error_message = "Secure VM Disk Encryption Set ID can only be used with DiskWithVMGuestState security encryption type."
    }
}

variable "os_image_notification" {
    default = null
    description = "OS image notification settings for the virtual machine"
    nullable = true
    type = object({
        tiemout = optional(string, "PT15M")
    })
}

variable "patch_assessment_mode" {
    default = "ImageDefault"
    description = "Patch assessment mode for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([contains([
            "AutomaticByPlatform", "ImageDefault"
        ], var.patch_assessment_mode), var.patch_assessment_mode == null])
        error_message = "Patch assessment mode must be null or one of AutomaticByPlatform or ImageDefault. Defaults to ImageDefault."
    }
}

variable "patch_mode" {
    default = "ImageDefault"
    description = "Patch mode for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = contains([
            "AutomaticByPlatform", "ImageDefault"
        ], var.patch_mode)
        error_message = "Patch mode must be one of AutomaticByPlatform or ImageDefault. Defaults to ImageDefault."
    }
}

variable "plan" {
    default = null
    description = "Plan for the virtual machine"
    nullable = true
    type = object({
        name = string
        product = string
        publisher = string
    })
}

variable "platform_fault_domain" {
    default = null
    description = "Platform fault domain for the virtual machine. Set to -1 for automatic assignment."
    nullable = true
    type = number
}

variable "priority" {
    default = "Regular"
    description = "Priority of the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([contains([
            "Regular", "Spot"
        ], var.priority), var.priority == null])
        error_message = "Priority can be either null or must be one of Regular or Spot. Defaults to Regular."
    }
}

variable "provision_vm_agent" {
    default = true
    description = "Provision the VM agent on the virtual machine"
    nullable = true
    type = bool
}

variable "proximity_placement_group_id" {
    default = null
    description = "ID of the proximity placement group to associate with the virtual machine"
    nullable = true
    type = string
}

variable "reboot_setting" {
    default = null
    description = "Reboot setting for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.reboot_setting == null, 
            contains([
                "Always", "IfRequired", "Never"
                ], var.reboot_setting))
            ])
        error_message = "Reboot setting can be null or must be one of Always, IfRequired, or Never."
    }
    validation {
        condition = anytrue([
            var.reboot_setting == null, 
            alltrue([
                var.reboot_setting != null, var.patch_mode == "AutomaticByPlatform"
            ])
        ])
        error_message = "Reboot setting can only be set if patch mode is set to AutomaticByPlatform."
    }
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "secure_boot_enabled" {
    default = false
    description = "Enable secure boot for the virtual machine"
    type = bool
}

variable "size" {
    default = "Standard_B2LS_v2"
    description = "Size of the virtual machine"
    type = string
}

variable "source_image_id" {
    default = null
    description = "ID of the source image to use for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = anytrue([
            try(var.source_image_id == null, 
            contains([
                "Community Gallery Image ID", "Community Gallery Image Version ID", "Image ID", "Shared Image ID", "Shared Image Version ID", "Shared Gallery Image ID", "Shared Gallery Image Version ID"
            ], var.source_image_id))
        ])
        error_message = "Source image ID must be null or one of Community Gallery Image ID, Community Gallery Image Version ID, Image ID, Shared Image ID, Shared Image Version ID, Shared Gallery Image ID, or Shared Gallery Image Version ID."
    }
}

variable "source_image_reference" {
    default = null
    description = "Source image reference for the virtual machine"
    nullable = true
    type = object({
        offer = string
        publisher = string
        sku = string
        version = string
    })
    validation {
        condition = anytrue([
            alltrue([var.source_image_reference == null, var.source_image_id != null]), 
            alltrue([var.source_image_reference != null, var.source_image_id == null])
        ])
        error_message = "Either Source image reference or Source image ID can be provided, but not both."
    }
}

variable "tags" {
    description = "Tags to be applied to the virtual network"
    type = map(string)
}

variable "termination_notification" {
    default = null
    description = "Termination notification settings for the virtual machine. If timeout is provided, it must be between 5 and 15 minutes. Must be provided in ISO 8601 format. Defaults to PT5M."
    nullable = true
    type = object({
        enabled = bool
        timeout = optional(string, "PT5M")
    })

}

variable "user_data" {
    default = null
    description = "User data to be passed to the virtual machine. Must be in Base64 format."
    nullable = true
    type = string
}

variable "vtpm_enabled" {
    default = null
    description = "Enable vTPM for the virtual machine"
    nullable = true
    type = bool
}

variable "virtual_machine_scale_set_id" {
    default = null
    description = "ID of the virtual machine scale set to associate with the virtual machine"
    nullable = true
    type = string
}

variable "zone" {
    default = "1"
    description = "Zone for the virtual machine"
    nullable = true
    type = string
    validation {
        condition = contains(["1", "2", "3"], var.zone)
        error_message = "Zone must be null or one of 1, 2, or 3."
    }
}