# terraform-azurerm-loadbalancer
This repository is to maintain Terraform Module
#### This module if used to create Public Loadbalancer with Default rule to forward port 22 to the backend pool address.

#### At present this is module has only 1 backend-pool which can further be extended created multiple backend pools.
#### `For_Each` is used to create multiple Rules & Probes for the single backend pool. 