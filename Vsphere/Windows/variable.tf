variable "dc" {
  description = "Name of the datacenter"
  type        = string
}

variable "datastore" {
  description = "Name of the datastore"
  type        = string
}

variable "vmrp" {
  description = "Name of the resource pool"
  type        = string
}

variable "network_cards" {
  description = "Name of the network"
  type        = string
}

variable "name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "guest_id" {
  description = "Guest ID for the virtual machine"
  type        = string
}

variable "cpu_number" {
  description = "Number of CPUs for the virtual machine"
  type        = number
}

variable "ram_size" {
  description = "RAM size for the virtual machine in MB"
  type        = number
}

variable "disk_label" {
  description = "Label for the disk"
  type        = string
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
}

variable "thinprovisoned" {
  description = "Whether the disk is thin provisioned"
  type        = bool
}

variable "tags" {
  description = "Tags for the virtual machine"
  type        = map(string)
  default     = null
}


Feel free to adjust the descriptions and types as needed for your specific use case! If you have any more questions or need further assistance, just let me know.
