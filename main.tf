terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = "us-ashburn-1"
  auth                = "SecurityToken"
  config_file_profile = "learn-terraform"
}

resource "oci_identity_compartment" "_" {
  name          = var.name
  description   = var.name
  enable_delete = true
}

locals {
  compartment_id = oci_identity_compartment._.id
}

data "oci_identity_availability_domains" "_" {
  compartment_id = local.compartment_id
}

data "oci_core_images" "_" {
  compartment_id           = local.compartment_id
  shape                    = var.shape
#   operating_system         = "Canonical Ubuntu"
#   operating_system_version = "20.04"
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
}

resource "oci_core_instance" "a" {
  availability_domain = data.oci_identity_availability_domains._.availability_domains[var.availability_domain].name
  compartment_id      = local.compartment_id
  shape               = var.shape
  source_details {
    source_id   = data.oci_core_images._.images[0].id
    source_type = "image"
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet._.id
    private_ip = "10.0.0.10"
  }
  shape_config {
    memory_in_gbs = "1"
    ocpus         = "1"
  }
  metadata = {
        ssh_authorized_keys = file(var.path_local_public_key)
    } 
}

resource "oci_core_instance" "b" {
  availability_domain = data.oci_identity_availability_domains._.availability_domains[var.availability_domain].name
  compartment_id      = local.compartment_id
  shape               = var.shape
  source_details {
    source_id   = data.oci_core_images._.images[0].id
    source_type = "image"
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet._.id
    private_ip = "10.0.0.20"
  }
  shape_config {
    memory_in_gbs = "1"
    ocpus         = "1"
  }
  metadata = {
        ssh_authorized_keys = file(var.path_local_public_key)
    } 
}