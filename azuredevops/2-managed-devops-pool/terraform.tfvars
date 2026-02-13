subscription_id     = "a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf"
resource_group_name = "managed-devops-pool"
location            = "switzerlandnorth"

name                                     = "mdp-brewstack"
dev_center_project_resource_id           = "/subscriptions/a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf/resourceGroups/managed-devops-pool/providers/Microsoft.DevCenter/projects/mdp-project"
version_control_system_organization_name = "brewstack"
version_control_system_project_names     = ["ASSET-Platform-DEV"]

vnet_address_space      = "10.51.0.0/16"
subnet_address_prefix   = "10.51.1.0/24"
maximum_concurrency     = 2
fabric_profile_sku_name = "Standard_E2as_v4"
agent_profile_kind      = "Stateless"

fabric_profile_images = [{
  well_known_image_name = "ubuntu-22.04/latest"
  aliases               = ["ubuntu-22.04/latest"]
}]

# Platform VNet peering (for private endpoint access to tfstate)
platform_vnet_name              = "ivo-odd-dataplatform-platform-dev-weu-vnet"
platform_vnet_resource_group    = "ivo-odd-dataplatform-networking-dev-weu-rg"
private_dns_zone_resource_group = "ivo-odd-dataplatform-terraform-dev-weu-rg"

tags = {
  
}