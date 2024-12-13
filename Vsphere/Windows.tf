# ==============================================================================
#   DataStore(s)
# ==============================================================================
#In this example, the resource makes use of the following data sources:

#to locate the datacenter,
data "vsphere_datacenter" "dc" {
  name = var.dc
}


data "vsphere_datastore_cluster" "datastore_cluster" {
  count         = var.ds_cluster != "" ? 1 : 0
  name          = var.ds_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

#to locate the default datastore to place the virtual machine files,
data "vsphere_datastore" "datastore" {
  count         = var.datastore != "" && var.ds_cluster == "" ? 1 : 0
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

#ID of a resource pool in vSphere to create and manage.
data "vsphere_resource_pool" "pool" {
  name          = var.vmrp
  datacenter_id = data.vsphere_datacenter.dc.id
}

#to locate the network
data "vsphere_network" "network" {
  count         = var.network_cards != null ? length(var.network_cards) : 0
  name          = var.network_cards[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ==============================================================================
#   Resource(s)
# ==============================================================================

resource "vsphere_virtual_machine" "Windows" {
  name       = "%{if var.vmnameliteral != ""}${var.vmnameliteral}%{else}${var.vmname}${count.index + 1}${var.vmnamesuffix}%{endif}"
  # ----------------------------------------------------------------------------
  #   vSphere resources
  # ----------------------------------------------------------------------------
  resource_pool_id = data.vsphere_resource_pool.resourcepool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  # ----------------------------------------------------------------------------
  #   VM options
  # ----------------------------------------------------------------------------
  guest_id             = data.vsphere_virtual_machine.template.guest_id

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
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]


  # ----------------------------------------------------------------------------
  #  Disk options
  # ----------------------------------------------------------------------------
 
  disk {
    label             = var.disk_label
    size              = var.disk_size_gb != null ? var.disk_size_gb : data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned  = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  # ----------------------------------------------------------------------------
  #  Other options
  # ----------------------------------------------------------------------------
  tags              = var.tags
}
