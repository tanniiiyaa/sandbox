variable "resource_group_name" {
  description = "Sandbox resource group name"
  type        = string
}

variable "location" {
  description = "East US"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

variable "ssh_public_key" {
  description = "SSH public key for VM login"
  type        = string
}

variable "sql_admin_username" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}