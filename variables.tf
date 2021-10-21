variable resource_group {
  type        = string
  default     = "k8srg"
  description = "resource group for the installation"
}

variable location {
  type        = string
  default     = "northeurope"
  description = "azure location for installation"
}

variable vnet_name {
  type        = string
  default     = "k8s-vnet"
  description = "name of the virtual network that will be created for the installation"
}

variable subnet_name {
  type        = string
  default     = "k8s-subnet"
  description = "name of subnet inside the virtual network, k8s will be located in"
}

variable public_ip_name {
  type        = string
  default     = "traefik-pub-ip"
  description = "name of the public ip for traefik ingress"
}

variable aks_name {
  type        = string
  default     = "k8s"
  description = "name of the k8s cluster"
}

variable nodepool_vm_sku {
  type        = string
  default     = "Standard_B2s"
  description = "description"
}
