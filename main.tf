##############################################################################
# This is default entrypoint.
#  - Ensure user provided region is valid
#  - Ensure user provided resource_group is valid
##############################################################################
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.30.0"
    }
  }
}

provider "ibm" {
  region           = var.region
  ibmcloud_timeout = 300
}

##############################################################################
# Read/validate Region
##############################################################################
data "ibm_is_region" "region" {
  name = var.region
}
