module "resource_group" {
    source = "../../modules/base/azure/resource-group"
    location = local.location
    name = local.resource_group_name
    tags = local.tags
}

module "virtual_network" {
    source = "../../modules/network/azure/virtual-network"
    depends_on = [ module.resource_group.location, module.resource_group.name ]
    address_space = local.virtual_network_address_space
    name = "vnet-${local.prefix}"
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    tags = local.tags
}

module "subnet" {
    source = "../../modules/network/azure/subnet"
    depends_on = [ module.virtual_network.id, module.resource_group.location, module.resource_group.name ]
    address_prefixes = local.subnet_address_space
    name = local.subnet_name
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    virtual_network_name = module.virtual_network.name
}

module "network_security_group" {
    source = "../../modules/network/azure/network-security-group"
    depends_on = [ module.resource_group.location, module.resource_group.name ]
    name = "nsg-${local.prefix}"
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    security_rules = local.network_security_rules
    tags = local.tags
}

module "public_ip" {
    source = "../../modules/network/azure/public-ip"
    depends_on = [ module.resource_group.location, module.resource_group.name ]
    count = local.virtual_machine_count
    allocation_method = local.public_ip.allocation_method
    name = join("", ["ip-${local.prefix}-", substr("000${count.index+1}", -3, 3)])
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    sku = local.public_ip.sku
    sku_tier = local.public_ip.sku_tier
    tags = local.tags
}

module "network_interface" {
    source = "../../modules/network/azure/network-interface"
    depends_on = [ module.network_security_group.id, module.subnet.id, module.virtual_network, module.resource_group.location, module.resource_group.name, module.public_ip.id ]
    count = local.virtual_machine_count
    ip_configuration = {
        name = join("", ["pip-${local.prefix}-", substr("000${count.index +1}", -3, 3)])
        primary = true
        private_ip_address = "${local.network_interface_card_private_ip_prefix}${count.index}"
        private_ip_address_allocation = local.network_interface_card_private_ip_allocation
        private_ip_address_version = local.network_interface_card_private_ip_version
        public_ip_address_id = module.public_ip[count.index].id
        subnet_id = module.subnet.id
    }
    name = join("", ["nic-${local.prefix}-", substr("000${count.index+1}", -3, 3)])
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    tags = local.tags
}

module "ssh_key" {
    source = "../../modules/security/generic/tls-private-key"
}

module "private_ssh_key" {
    source = "../../modules/base/generic/local-file-sensitive"
    depends_on = [ module.ssh_key.private_key_openssh ]
    content = module.ssh_key.private_key_openssh
    file_permission = "0600"
    filename = "${path.module}/sshkey-${local.prefix}.pem"
}

module "virtual_machine" {
    source = "../../modules/compute/azure/linux-virtual-machine"
    depends_on = [ module.network_interface.id, module.ssh_key.public_key_openssh, module.resource_group.location, module.resource_group.name ]
    count = local.virtual_machine_count
    name = join("", ["vm-${local.prefix}-", substr("000${count.index+1}", -3, 3)])
    admin = {
        public_key = module.ssh_key.public_key_openssh
        username = local.virtual_machine.admin_username
    }
    network_interface_ids = [module.network_interface[count.index].id]
    os_disk = {
        caching = "ReadWrite"
        create_option = "FromImage"
        diff_disk_settings = null
        storage_account_type = "Standard_LRS"
    }
    resource_group = {
        location = module.resource_group.location
        name = module.resource_group.name
    }
    size = local.virtual_machine.size
    source_image_reference = {
        publisher = local.virtual_machine.source_image_reference.publisher
        offer = local.virtual_machine.source_image_reference.offer
        sku = local.virtual_machine.source_image_reference.sku
        version = local.virtual_machine.source_image_reference.version
    }
    tags = local.tags
}

module "subnet_network_security_group_association" {
    source = "../../modules/network/azure/subnet-network-security-group-association"
    depends_on = [ module.network_security_group.id, module.subnet.id, module.virtual_network.id]
    network_security_group_id = module.network_security_group.id
    subnet_id = module.subnet.id
}