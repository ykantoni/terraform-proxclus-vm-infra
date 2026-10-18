proxmox_endpoint = "https://192.168.1.15:8006/"
proxmox_node     = "jupiter"

datastore_id = "sdc-storage"
bridge       = "vmbr0"

nodes = {
  cp1 = {
    vm_id  = 10000
    name   = "cp1"
    ip     = "192.168.1.201"
    mac    = "BC:24:11:00:01:01"
    role   = "controlplane"
    cores  = 2
    memory = 6144
    disk   = 100
  }

  worker1 = {
    vm_id  = 10001
    name   = "w1"
    ip     = "192.168.1.202"
    mac    = "BC:24:11:00:01:02"
    role   = "worker"
    cores  = 4
    memory = 12284
    disk   = 100
    pcigpu = "RTX5060Ti"
  }

  worker2 = {
    vm_id  = 10002
    name   = "w2"
    ip     = "192.168.1.203"
    mac    = "BC:24:11:00:01:03"
    role   = "worker"
    cores  = 4
    memory = 8192
    disk   = 100
  }

  worker3 = {
    vm_id  = 10003
    name   = "w3"
    ip     = "192.168.1.204"
    mac    = "BC:24:11:00:01:04"
    role   = "worker"
    cores  = 4
    memory = 8192
    disk   = 100
  }

  worker4 = {
    vm_id  = 10004
    name   = "w4"
    ip     = "192.168.1.205"
    mac    = "BC:24:11:00:01:05"
    role   = "worker"
    cores  = 4
    memory = 8192
    disk   = 100
  }

  worker5 = {
    vm_id  = 10005
    name   = "w5"
    ip     = "192.168.1.206"
    mac    = "BC:24:11:00:01:06"
    role   = "worker"
    cores  = 4
    memory = 8192
    disk   = 100
  }
}
