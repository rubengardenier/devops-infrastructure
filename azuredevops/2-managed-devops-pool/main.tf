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

  delegation {
    name = "Microsoft.DevOpsInfrastructure.pools"
    service_delegation {
      name = "Microsoft.DevOpsInfrastructure/pools"
    }
  }
}

# RBAC for DevOpsInfrastructure service principal on the VNet
data "azuread_service_principal" "devopsinfrastructure" {
  display_name = "DevOpsInfrastructure"
}

resource "azurerm_role_assignment" "devops_infra_reader" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_service_principal.devopsinfrastructure.object_id
}

resource "azurerm_role_assignment" "devops_infra_network_contributor" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.devopsinfrastructure.object_id
}

# =============================================================================
# Global VNet Peering – MDP VNet <-> Platform VNet
# =============================================================================

data "azurerm_virtual_network" "platform" {
  count               = var.platform_vnet_name != "" ? 1 : 0
  name                = var.platform_vnet_name
  resource_group_name = var.platform_vnet_resource_group
}

resource "azurerm_virtual_network_peering" "mdp_to_platform" {
  count                     = var.platform_vnet_name != "" ? 1 : 0
  name                      = "mdp-to-platform"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.platform[0].id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "platform_to_mdp" {
  count                     = var.platform_vnet_name != "" ? 1 : 0
  name                      = "platform-to-mdp"
  resource_group_name       = var.platform_vnet_resource_group
  virtual_network_name      = var.platform_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  allow_forwarded_traffic   = true
}

# =============================================================================
# Private DNS Zone Link – MDP VNet needs to resolve private endpoints
# =============================================================================

data "azurerm_private_dns_zone" "blob" {
  count               = var.private_dns_zone_resource_group != "" ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "mdp_blob" {
  count                 = var.private_dns_zone_resource_group != "" ? 1 : 0
  name                  = "mdp-vnet-link"
  resource_group_name   = var.private_dns_zone_resource_group
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# =============================================================================
# Managed DevOps Pool
# =============================================================================

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
  fabric_profile_sku_name                    = var.fabric_profile_sku_name
  fabric_profile_os_disk_storage_account_type = "Standard"
  agent_profile_kind                         = var.agent_profile_kind
  fabric_profile_images                      = var.fabric_profile_images

  tags = var.tags
}
