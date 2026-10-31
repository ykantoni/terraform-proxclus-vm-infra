# Task runner for the VM layer. Run `just --list` to see all recipes.

# OpenTofu by default. For Terraform: `TF=terraform just <recipe>` or
# `just tf=terraform <recipe>`. After changing tools, run `just switch` once.
tf := env("TF", "tofu")

plan:
    {{tf}} plan

# Install providers for the selected tool.
init:
    {{tf}} init -input=false

# Run once after changing tools. State written by tofu records
# registry.opentofu.org providers; left in place, Terraform would install those
# unpinned, ignoring versions.tf. tofu needs only the init.
switch:
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{tf}}" = terraform ]; then
      providers=$(terraform state pull | grep -oE 'registry\.opentofu\.org/[a-z0-9-]+/[a-z0-9-]+' | sort -u || true)
      for p in $providers; do
        terraform state replace-provider -auto-approve "$p" "registry.terraform.io/${p#registry.opentofu.org/}"
      done
    fi
    {{tf}} init -input=false

apply:
    {{tf}} apply -auto-approve

# Destroy the VMs. Destroy terraform-proxclus-k8s-infra first.
destroy:
    {{tf}} destroy -auto-approve

fmt:
    {{tf}} fmt -recursive

# Build both Proxmox VM templates: the plain one (vm_id 9000) common nodes
# clone from, and the NVIDIA one (vm_id 9001) GPU-tagged nodes clone from.
t-create:
    /usr/bin/bash -c "pushd vm-templates && sudo ./qemu-iscsi-2c.sh && sudo ./nvidia-qemu-iscsi-2c.sh && popd"

# Destroy both templates.
t-destroy:
    sudo /usr/sbin/qm destroy 9000
    sudo /usr/sbin/qm destroy 9001
