# ==============================================================================
#   Providers
# ==============================================================================

terraform {}

provider "vsphere" {
  version = "~> 1.16"
  # --
  vsphere_server       = var.vsphere.address
  user                 = var.vsphere.username
  password             = var.vsphere_password
  allow_unverified_ssl = true
}
