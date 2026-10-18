terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111.1"
    }

    talos = {
      source = "siderolabs/talos"
    }
  }

  # terraform-proxclus-k8s-infra reads this file's outputs (nodes, schematic
  # IDs) through terraform_remote_state, so moving it means updating that
  # stack's vm_infra_state_path too.
  backend "local" {
    path = "/home/yurick/terraform/state/vm-infra.tfstate"
  }
}
