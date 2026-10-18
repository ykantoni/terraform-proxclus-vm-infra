# nodes and the schematic IDs are the contract terraform-proxclus-k8s-infra
# consumes via terraform_remote_state; rename them only together with it.
output "nodes" {
  value = module.proxmox_talos_vms.nodes
}

output "vm_ids" {
  value = module.proxmox_talos_vms.vm_ids
}

output "talos_schematic_id_common" {
  value = talos_image_factory_schematic.common.id
}

output "talos_schematic_id_gpu" {
  value = talos_image_factory_schematic.gpu.id
}
