module "windows_vm" {
  source          = "./windows"
  dc              = "example-ds"
  datastore       = "example-ds"
  vmrp            = "VMW/Resources"
  network_cards   = "example-nw"
  name            = "My_Test_Windows_Server"
  guest_id        = "windows9_64Guest"
  cpu_number      = 2
  ram_size        = 4096
  disk_label      = "Disk1"
  disk_size_gb    = 50
  thinprovisoned  = true
}
