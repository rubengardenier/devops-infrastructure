variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

# Zet dit bij voorkeur op jouw publieke IP/CIDR, bv. "1.2.3.4/32"
variable "ssh_source_cidr" {
  type = string
}
