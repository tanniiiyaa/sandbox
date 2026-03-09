variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "frontdoor_name" {
  type = string
}

variable "endpoint_name" {
  type = string
}

variable "origin_host_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}