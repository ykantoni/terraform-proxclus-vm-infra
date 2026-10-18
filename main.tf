module "proxmox_talos_vms" {
  source = "./modules/proxmox-talos-vm"

  proxmox_node = var.proxmox_node
  datastore_id = var.datastore_id
  bridge       = var.bridge

  nodes = var.nodes
}
