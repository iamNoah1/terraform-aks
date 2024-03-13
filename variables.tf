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

variable aks_name {
  type        = string
  default     = "k8s"
  description = "name of the k8s cluster"
}

variable nodepool_vm_sku {
  type        = string
  default     = "Standard_B2s"
  description = "SKU for the nodepool VMs"
}

variable node_count {
  type        = number
  default     = 1
  description = "Node count for the nodepool"
}
