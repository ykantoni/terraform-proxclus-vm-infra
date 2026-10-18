# Task runner for the VM layer. Run `just --list` to see all recipes.

plan:
    terraform plan

apply:
    terraform apply -auto-approve

# Destroy the VMs. Destroy terraform-proxclus-k8s-infra first.
destroy:
    terraform destroy -auto-approve

fmt:
    terraform fmt -recursive

# Build both Proxmox VM templates: the plain one (vm_id 9000) common nodes
# clone from, and the NVIDIA one (vm_id 9001) GPU-tagged nodes clone from.
t-create:
    /usr/bin/bash -c "pushd vm-templates && sudo ./qemu-iscsi-2c.sh && sudo ./nvidia-qemu-iscsi-2c.sh && popd"

# Destroy both templates.
t-destroy:
    sudo /usr/sbin/qm destroy 9000
    sudo /usr/sbin/qm destroy 9001
