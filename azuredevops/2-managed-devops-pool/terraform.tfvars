subscription_id     = "a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf"
resource_group_name = "managed-devops-pool"
location            = "westeurope"

name                                     = "mdp-agents"
dev_center_project_resource_id           = "/subscriptions/a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf/resourceGroups/managed-devops-pool/providers/Microsoft.DevCenter/projects/mdp-project"
version_control_system_organization_name = "brewstack"
version_control_system_project_names     = ["brewstack"]

vnet_address_space      = "10.51.0.0/16"
subnet_address_prefix   = "10.51.1.0/24"
maximum_concurrency     = 1
fabric_profile_sku_name = "Standard_D2ads_v5"
agent_profile_kind      = "Stateless"

fabric_profile_images = [{
  well_known_image_name = "ubuntu-22.04/latest"
  aliases               = ["ubuntu-22.04/latest"]
}]

tags = {

}
