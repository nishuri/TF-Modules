# ==============================================================================
#   DataStore(s)
# ==============================================================================
#In this example, the resource makes use of the following data sources:

#To locate the datacenter,
data "vsphere_datacenter" "dc" {
  name = var.dc
}

#To locate the default datastore to place the virtual machine files,
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

#ID of a resource pool in vSphere to create and manage.
data "vsphere_resource_pool" "pool" {
  name          = var.vmrp
  datacenter_id = data.vsphere_datacenter.dc.id
}

#To locate the network
data "vsphere_network" "network" {
  count         = var.network_cards != null ? length(var.network_cards) : 0
  name          = var.network_cards[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ==============================================================================
#   Resource(s)
# ==============================================================================

resource "vsphere_virtual_machine" "Windows" {
  name       = var.name
  # ----------------------------------------------------------------------------
  #   vSphere resources
  # ----------------------------------------------------------------------------
  resource_pool_id = data.vsphere_resource_pool.resourcepool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  # ----------------------------------------------------------------------------
  #   VM options
  # ----------------------------------------------------------------------------
  guest_id             = var.guest_id

  # ----------------------------------------------------------------------------
  #   CPU and memory options
  # ----------------------------------------------------------------------------
  num_cpus               = var.cpu_number
  memory                 = var.ram_size

  # ----------------------------------------------------------------------------
  #   Network interface options
  # ----------------------------------------------------------------------------
  network_interface {
    network_id   = data.vsphere_network.network.id
   }

  # ----------------------------------------------------------------------------
  #  Disk options
  # ----------------------------------------------------------------------------
 
  disk {
    label             = var.disk_label
    size              = var.disk_size_gb
    thin_provisioned  = var.thinprovisoned
  }

  # ----------------------------------------------------------------------------
  #  Other options
  # ----------------------------------------------------------------------------
  tags              = var.tags
}
