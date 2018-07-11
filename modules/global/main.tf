provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datastore" "datastore" {
  name          = "DS1"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

variable "hosts" {
  default = [
    "192.168.1.52"
  ]
}

data "vsphere_datacenter" "dc" {
  name = "${var.datacenter}"
}

data "vsphere_host" "hosts" {
  count         = "${length(var.hosts)}"
  name          = "${var.hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "hosts" {
  count         = "${length(var.hosts)}"
  name          = "${var.hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

module "cluster" {
source  = "../shared/computeCluster"
}

module "pool" {
source = "../shared/resourcePool"
}

module "host" {
source = "../shared/centOSbase"
pool = "${module.pool.name}"
}
