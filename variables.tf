variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "rg_unyleya"
}

variable "acr_name" {
  default = "unyleyaregistry"
}

variable "aks_cluster_name" {
  default = "aks-unyleya-cluster"
}

variable "node_count" {
  default = 2
}

variable "node_vm_size" {
  default = "Standard_DS2_v2"
}

variable "subscription_id" {
    default = "20abd4eb-1871-46f1-bdb3-02a0a29ba729"
}