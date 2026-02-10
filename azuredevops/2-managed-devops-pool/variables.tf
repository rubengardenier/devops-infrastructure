variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the Managed DevOps Pool (3-44 chars, globally unique per Azure DevOps Org)."
}

variable "dev_center_project_resource_id" {
  type        = string
  description = "The resource ID of the Dev Center project."
}

variable "version_control_system_organization_name" {
  type        = string
  description = "The name of the Azure DevOps organization."
}

variable "version_control_system_project_names" {
  type = set(string)
}

variable "vnet_address_space" {
  type = string
}

variable "subnet_address_prefix" {
  type = string
}

variable "maximum_concurrency" {
  type = number
}

variable "fabric_profile_sku_name" {
  type = string
}

variable "agent_profile_kind" {
  type = string

  validation {
    condition     = contains(["Stateless", "Stateful"], var.agent_profile_kind)
    error_message = "Must be Stateless or Stateful."
  }
}

variable "fabric_profile_images" {
  type = list(object({
    well_known_image_name = optional(string)
    resource_id           = optional(string)
    aliases               = optional(list(string))
    buffer                = optional(string, "*")
  }))
}

variable "tags" {
  type = map(string)
}
