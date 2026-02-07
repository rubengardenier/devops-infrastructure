subscription_id     = "a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf"
resource_group_name = "devops-agent"

location       = "westeurope"
name_prefix    = "ado-agent"
vm_size        = "Standard_B1ms"
admin_username = "azureuser"

ssh_public_key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2KKQT5JhNrLW+wTG+C8bbnwaq1s5yjTAE6RyhdtGzJ ado-agent"
ssh_source_cidr = "143.179.21.185"