variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint"
  type        = string
}

variable "proxmox_node" {
  description = "Proxmox node on which the VMs are created"
  type        = string
}

variable "datastore_id" {
  description = "Proxmox datastore for Talos VM disks"
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  description = "Proxmox network bridge"
  type        = string
  default     = "vmbr0"
}

variable "nodes" {
  description = "Talos cluster nodes"

  type = map(object({
    vm_id = number
    name  = string
    ip    = string
    cidr  = optional(number, 24)
    mac   = string
    role  = string

    pcigpu = optional(string, null)
    cores  = optional(number, 4)
    memory = optional(number, 4096)
    disk   = optional(number, 32)
  }))

  validation {
    condition = alltrue([
      for node in values(var.nodes) :
      contains(["controlplane", "worker"], node.role)
    ])

    error_message = "role must be either controlplane or worker."
  }
}
