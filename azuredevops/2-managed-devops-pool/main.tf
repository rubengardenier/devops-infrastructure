resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

module "managed_devops_pool" {
  source  = "Azure/avm-res-devopsinfrastructure-pool/azurerm"
  version = "~> 0.2"

  resource_group_name            = var.resource_group_name
  location                       = var.location
  name                           = var.name
  dev_center_project_resource_id = var.dev_center_project_resource_id

  version_control_system_organization_name = var.version_control_system_organization_name
  version_control_system_project_names     = var.version_control_system_project_names

  subnet_id               = azurerm_subnet.subnet.id
  maximum_concurrency     = var.maximum_concurrency
  fabric_profile_sku_name = var.fabric_profile_sku_name
  agent_profile_kind      = var.agent_profile_kind
  fabric_profile_images   = var.fabric_profile_images

  tags = var.tags
}
