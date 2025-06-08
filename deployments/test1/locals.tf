locals {
    location = "centralus"
    network_interface_card_private_ip_prefix = "10.0.0."
    network_interface_card_private_ip_version = "IPv4"
    network_interface_card_private_ip_allocation = "Static"
    network_security_rules = [
        {
            name = "Allow-SSH"
            description = "Allow SSH"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "22"
            source_address_prefix = "*"
            destination_address_prefix = "*"
            access = "Allow"
            priority = 1000
            direction = "Inbound"
        }
    ]
    prefix = "tf-test1"
    public_ip = {
        allocation_method = "Static"
        sku = "Standard"
        sku_tier = "Regional"
    }
    resource_group_name = "rg-tf-test1"
    subnet_address_space = ["10.0.0.0/24"]
    subnet_name = "default"
    tags = {
        owner = "josanders"
    }
    virtual_machine = {
        admin_username = "azureadmin"
        size = "Standard_B2LS_v2"
        source_image_reference = {
            publisher = "canonical"
            offer = "ubuntu-24_04-lts"
            sku = "ubuntu-pro"
            version = "latest"
        }
    }
    virtual_machine_count = 3
    virtual_network_address_space = ["10.0.0.0/16"]
}