module "windows_vm" {
  source          = "./windows"
  dc              = "Your_Datacenter_Name"
  datastore       = "Your_Datastore_Name"
  vmrp            = "Your_Resource_Pool_Name"
  network_cards   = "Your_Network_Name"
  name            = "Your_VM_Name"
  guest_id        = "Your_Guest_ID"
  cpu_number      = 2
  ram_size        = 4096
  disk_label      = "Your_Disk_Label"
  disk_size_gb    = 50
  thinprovisoned  = true
  tags            = ["tag1", "tag2"]
}
