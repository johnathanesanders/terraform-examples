resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
    dynamic "additional_capabilities" {
        for_each = var.additional_capabilities != null ? [var.additional_capabilities] : []
        content {
            hibernation_enabled = var.additional_capabilities.hibernation_enabled
            ultra_ssd_enabled   = var.additional_capabilities.ultra_ssd_enabled
        }
    }
    admin_username = var.admin.username
    admin_ssh_key {
        public_key = var.admin.public_key != null ? var.admin.public_key : file(var.admin.public_key_path)
        username = var.admin.username
    }
    allow_extension_operations = var.allow_extension_operations
    availability_set_id = var.availability_set_id
    dynamic "boot_diagnostics" {
        for_each = var.boot_diagnostics != null ? [var.boot_diagnostics] : []
        content {
            storage_account_uri = var.boot_diagnostics.storage_account_uri
        }
    }
    bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
    capacity_reservation_group_id = var.capacity_reservation_group_id
    computer_name = coalesce(var.computer_name, var.name)
    custom_data = var.custom_data
    dedicated_host_id = var.dedicated_host_id
    dedicated_host_group_id = var.dedicated_host_group_id
    disable_password_authentication = true
    disk_controller_type = var.disk_controller_type
    edge_zone = var.edge_zone
    encryption_at_host_enabled = var.encryption_at_host_enabled
    eviction_policy = var.eviction_policy
    extensions_time_budget = var.extensions_time_budget
    dynamic "gallery_application" {
        for_each = var.gallery_application != null ? [var.gallery_application] : []
        content {
            automatic_upgrade_enabled = var.gallery_application.automatic_upgrade_enabled
            configuration_blob_uri = var.gallery_application.configuration_blob_uri
            order = var.gallery_application.order
            tag = var.gallery_application.tag
            treat_failure_as_deployment_failure_enabled = var.gallery_application.treat_failure_as_deployment_failure_enabled
            version_id = var.gallery_application.version_id
        }
    }
    dynamic "identity" {
        for_each = var.identity != null ? [var.identity] : []
        content {
            identity_ids = var.identity.identity_ids
            type = var.identity.type
        }
    }
    license_type = var.license_type
    location = var.resource_group.location
    max_bid_price = var.max_bid_price
    name = var.name
    network_interface_ids = var.network_interface_ids
    os_disk {
        caching = var.os_disk.caching
        dynamic "diff_disk_settings" {
            for_each = var.os_disk.diff_disk_settings != null ? [var.os_disk.diff_disk_settings] : []
            content {
                option = var.os_disk.diff_disk_settings.option
                placement = var.os_disk.diff_disk_settings.placement
            }
        }
        disk_encryption_set_id = var.os_disk.disk_encryption_set_id
        disk_size_gb = var.os_disk.disk_size_gb
        name = var.os_disk.name
        secure_vm_disk_encryption_set_id = var.os_disk.secure_vm_disk_encryption_set_id
        security_encryption_type = var.os_disk.security_encryption_type
        storage_account_type = var.os_disk.storage_account_type
        write_accelerator_enabled = var.os_disk.write_accelerator_enabled
    }
    dynamic "os_image_notification" {
        for_each = var.os_image_notification != null ? [var.os_image_notification] : []
        content {
            timeout = var.os_image_notification.timeout
        }
    }
    patch_assessment_mode = var.patch_assessment_mode
    patch_mode = var.patch_mode
    dynamic "plan" {
        for_each = var.plan != null ? [var.plan] : []
        content {
            name = var.plan.name
            product = var.plan.product
            publisher = var.plan.publisher
        }
    }
    platform_fault_domain = var.platform_fault_domain
    priority = var.priority
    provision_vm_agent = var.provision_vm_agent
    proximity_placement_group_id = var.proximity_placement_group_id
    reboot_setting = var.reboot_setting
    resource_group_name = var.resource_group.name
    secure_boot_enabled = var.secure_boot_enabled
    size = var.size
    source_image_id = var.source_image_id != null ? var.source_image_id : null
    dynamic "source_image_reference" {
        for_each = var.source_image_reference != null ? [var.source_image_reference] : []
        content {
            offer = var.source_image_reference.offer
            publisher = var.source_image_reference.publisher
            sku = var.source_image_reference.sku
            version = var.source_image_reference.version
        }
    }
    tags = var.tags
    dynamic "termination_notification" {
        for_each = var.termination_notification != null ? [var.termination_notification] : []
        content {
            enabled = var.termination_notification.enabled
            timeout = var.termination_notification.timeout
        }
    }
    user_data = var.user_data
    vtpm_enabled = var.vtpm_enabled
    virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
    zone = var.zone
}