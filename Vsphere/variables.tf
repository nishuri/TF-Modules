variable "vsphere_server" {
  description = "vSphere server address"
  type        = string
  sensitive   = true
}

variable "vsphere_username" {
  description = "vSphere username"
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}
