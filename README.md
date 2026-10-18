# terraform-proxclus-vm-infra

Proxmox VE virtual machines for the Talos Linux Kubernetes cluster, plus the
Talos image schematics they boot from. The cluster itself is bootstrapped by
[terraform-proxclus-k8s-infra](https://github.com/ykantoni/terraform-proxclus-k8s-infra),
which reads this stack's outputs.

## Layout

- `modules/proxmox-talos-vm` — Proxmox VMs, cloned from template 9000 (common)
  or 9001 (NVIDIA, for nodes with `pcigpu` set)
- `schematic.tf` — Talos image factory schematics, derived from
  `customization-common.yaml` and `customization-gpu.yaml`
- `vm-templates/` — scripts that build the 9000/9001 Proxmox templates from
  the same customization files
- `proxmox-host/` — host-side config for GPU passthrough (vfio, BAR resize)

## Talos image

`customization-common.yaml` and `customization-gpu.yaml` are the single source
of truth for the image. Terraform derives the installer schematics from them,
and `vm-templates` builds the boot images from the same files, so the two
cannot disagree. Adding an extension is one line there.

Extensions only activate on install or upgrade, so adding one to a running
cluster is a `talosctl upgrade --image ...` — a rolling reboot — not just an
apply.

## Usage

```bash
just t-create   # build templates 9000 and 9001 (once)
just apply
```

State lives in `/home/yurick/terraform/state/vm-infra.tfstate`.

## Outputs contract

k8s-infra reads `nodes`, `talos_schematic_id_common` and
`talos_schematic_id_gpu` from this stack's state through
`terraform_remote_state`. Renaming any of them, or moving the state file,
needs the matching change there.

Destroying this stack removes the VMs out from under the cluster. Destroy
k8s-infra first (the umbrella repo's `just destroy` does both in order).
