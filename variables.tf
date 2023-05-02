# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable subscriptionId {
  description ="Azure subscription Id"
}

# Update this if the script do-all.sh  fails nd you want to rerun it.
variable "revision" {
  default = 3 
}

variable clusterName {
  description ="AKS Cluster Name"
  default = "mxdemo"
}

variable "nodeCount" {
  description ="AKS Cluster number of nodes "
  default = 2 
}

variable "nodeMachineType" {
  description ="AKS Cluster node machine type "
  default = "Standard_A4_v2"
}
