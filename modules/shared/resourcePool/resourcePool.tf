variable "poolId" {
  default = [
  "Terraform"
  ]
}

resource "vsphere_resource_pool" "resource_pool" {
  name                    = "${var.poolId}"
  parent_resource_pool_id = "${data.vsphere_compute_cluster.compute_cluster.id}"
}

output "name" {
  value  = "${vsphere_resource_pool.resource_pool.name}"
}
