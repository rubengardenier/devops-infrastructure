resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "nsg" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "~> 0.4"

  name                = "${var.name_prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rules = {
    allow_ssh = {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = var.ssh_source_cidr
      destination_address_prefix = "*"
    }
  }
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.7"

  name                = "${var.name_prefix}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.50.0.0/16"]

  subnets = {
    subnet = {
      name             = "${var.name_prefix}-subnet"
      address_prefixes = ["10.50.1.0/24"]
      network_security_group = {
        id = module.nsg.resource_id
      }
    }
  }
}

module "vm" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "~> 0.18"

  name                = "${var.name_prefix}-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zone                = null
  os_type             = "Linux"
  sku_size            = var.vm_size

  encryption_at_host_enabled = false

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  account_credentials = {
    admin_credentials = {
      username                           = var.admin_username
      ssh_keys                           = [var.ssh_public_key]
      generate_admin_password_or_ssh_key = false
    }
  }

  network_interfaces = {
    nic = {
      name = "${var.name_prefix}-nic"
      ip_configurations = {
        ipconfig1 = {
          name                          = "ipconfig1"
          private_ip_subnet_resource_id = module.vnet.subnets["subnet"].resource_id
          create_public_ip_address      = true
          public_ip_address_name        = "${var.name_prefix}-pip"
        }
      }
    }
  }
}
