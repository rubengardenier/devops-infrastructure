variable "subscription_id" {
  type    = string
  default = "a5a51e6d-bc3e-4c08-b2cb-4d5dfb10d8bf"
}

variable "resource_group_name" {
  type    = string
  default = "devops-agent"
}

variable "location" {
  type    = string
  default = "westeurope"
} 

variable "name_prefix" {
  type    = string
  default = "ado-agent"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1ms"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type = string
}

# Zet dit bij voorkeur op jouw publieke IP/CIDR, bv. "1.2.3.4/32"
variable "ssh_source_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
