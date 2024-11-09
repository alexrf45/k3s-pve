terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }

  backend "s3" {

  }
}

provider "aws" {

}

provider "proxmox" {
  pm_api_url          = var.pm_url
  pm_api_token_id     = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure     = true
  pm_debug            = false
  pm_parallel         = 6
  pm_log_enable       = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}



module "server" {
  source       = "github.com/alexrf45/lab.git//proxmox-vm?ref=dev"
  onboot       = true
  scsihw       = "virtio-scsi-pci"
  bios         = "seabios"
  agent        = 1
  cores        = 2
  vcpu         = 2
  boot_disk    = "scsi0"
  nameserver   = "1.1.1.1"
  gateway      = "10.3.3.1"
  ciuser       = var.ciuser
  cipassword   = var.cipassword
  ssh_key_path = "~/.ssh/lab.pub"


  vm_config = {
    v1 = {
      node             = "thoth",
      template         = "k3s",
      tags             = "controlplane",
      description      = "server"
      vm_id            = "8001"
      memory           = "8092",
      size             = "300",
      vm_name          = "server-01",
      storage_location = "local-lvm",
      ip               = "10.3.3.40",
    },
    v2 = {
      node             = "horus",
      template         = "k3s",
      description      = "server",
      tags             = "controlplane",
      vm_id            = "8002"
      memory           = "8092",
      size             = "300",
      vm_name          = "server-02",
      storage_location = "data",
      ip               = "10.3.3.41",
    },
    v3 = {
      node             = "anubis",
      template         = "k3s",
      description      = "server",
      tags             = "controlplane",
      vm_id            = "8003"
      memory           = "8092",
      size             = "300",
      vm_name          = "server-03",
      storage_location = "local-lvm",
      ip               = "10.3.3.42",
    },

  }

}

module "node" {
  source       = "github.com/alexrf45/lab.git//proxmox-vm?ref=dev"
  onboot       = true
  scsihw       = "virtio-scsi-pci"
  bios         = "seabios"
  agent        = 1
  cores        = 2
  vcpu         = 2
  boot_disk    = "scsi0"
  nameserver   = "1.1.1.1"
  gateway      = "10.3.3.1"
  ciuser       = var.ciuser
  cipassword   = var.cipassword
  ssh_key_path = "~/.ssh/lab.pub"


  vm_config = {
    v1 = {
      node             = "bastet",
      template         = "k3s",
      tags             = "node",
      description      = "k3s node"
      vm_id            = "8004",
      memory           = "8092",
      size             = "200",
      vm_name          = "node-01",
      storage_location = "data",
      ip               = "10.3.3.43",
    },
    v2 = {
      node             = "thoth",
      template         = "k3s",
      description      = "k3s node"
      tags             = "node"
      vm_id            = "8005"
      memory           = "8092",
      size             = "300",
      vm_name          = "node-02",
      storage_location = "backup",
      ip               = "10.3.3.44",
    },
    v3 = {
      node             = "anubis",
      template         = "k3s",
      description      = "k3s node"
      tags             = "node"
      vm_id            = "8006"
      memory           = "8092",
      size             = "300",
      vm_name          = "node-03",
      storage_location = "local-lvm",
      ip               = "10.3.3.45",
    },
    v4 = {
      node             = "osiris",
      template         = "k3s",
      description      = "k3s node"
      tags             = "node"
      vm_id            = "8007"
      memory           = "8092",
      size             = "300",
      vm_name          = "node-04",
      storage_location = "data",
      ip               = "10.3.3.46",
    },
  }

}
