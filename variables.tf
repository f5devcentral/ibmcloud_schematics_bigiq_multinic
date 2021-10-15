##################################################################################
# region - The VPC region to instatiate the F5 BIG-IQ instance
##################################################################################
variable "region" {
  type        = string
  default     = "us-south"
  description = "The VPC region to instatiate the F5 BIG-IQ instance"
}

##################################################################################
# resource_group - The IBM Cloud resource group to create the F5 BIG-IQ instance
##################################################################################
variable "resource_group" {
  type        = string
  default     = "default"
  description = "The IBM Cloud resource group to create the F5 BIG-IQ instance"
}


##################################################################################
# instance_name - The name of the F5 BIG-IQ instance
##################################################################################
variable "instance_name" {
  type        = string
  default     = "f5-bigiq-01"
  description = "The VPC Instance name"
}

##################################################################################
# bigiq_custom_image - The custom VPC image to use for the F5 BIG-IQ instnace
##################################################################################
variable "bigiq_custom_image" {
  type        = string
  default     = ""
  description = "The custom VPC image to use for the F5 BIG-IQ instance"
}

##################################################################################
# bigiq_image_name - The name of VPC image to use for the F5 BIG-IQ instnace
##################################################################################
variable "bigiq_image_name" {
  type        = string
  default     = "big-iq-7.1"
  description = "The image to be used when provisioning the F5 BIG-IQ instance"
}

##################################################################################
# instance_profile - The name of the VPC profile to use for the F5 BIG-IQ instnace
##################################################################################
variable "instance_profile" {
  type        = string
  default     = "bx2-4x16"
  description = "The resource profile to be used when provisioning the F5 BIG-IQ instance"
}

##################################################################################
# ssh_key_name - The name of the public SSH key to be used when provisining F5 BIG-IQ
##################################################################################
variable "ssh_key_name" {
  type        = string
  default     = ""
  description = "The name of the public SSH key (VPC Gen 2 SSH Key) to be used when provisioning the F5 BIG-IQ instance"
}

##################################################################################
# The F5 BIQ-IP license basekey to activate against activate.f5.com
##################################################################################
variable "license_basekey" {
  type        = string
  default     = "none"
  description = "License registration key for the F5 BIG-IQ instance"
}

##################################################################################
# bigiq_admin_password - The password for the built-in admin F5 BIG-IQ user
##################################################################################
variable "bigiq_admin_password" {
  type        = string
  default     = ""
  description = "admin account password for the F5 BIG-IQ instance"
}

##################################################################################
# management_subnet_id - The VPC subnet ID for the F5 BIG-IQ management interface
##################################################################################
variable "management_subnet_id" {
  type        = string
  default     = null
  description = "Required VPC Gen2 subnet ID for the F5 BIG-IQ management network"
}

##################################################################################
# data_1_1_subnet_id - The VPC subnet ID for the F5 BIG-IQ 1.1 data interface
##################################################################################
variable "data_1_1_subnet_id" {
  type        = string
  default     = ""
  description = "Optional VPC Gen2 subnet ID for the F5 BIG-IQ 1.1 data network"
}

##################################################################################
# data_1_2_subnet_id - The VPC subnet ID for the F5 BIG-IQ 1.2 data interface
##################################################################################
variable "data_1_2_subnet_id" {
  type        = string
  default     = ""
  description = "Optional VPC Gen2 subnet ID for the F5 BIG-IQ 1.2 data network"
}

##################################################################################
# data_1_3_subnet_id - The VPC subnet ID for the F5 BIG-IQ 1.3 data interface
##################################################################################
variable "data_1_3_subnet_id" {
  type        = string
  default     = ""
  description = "Optional VPC Gen2 subnet ID for the F5 BIG-IQ 1.3 data network"
}

##################################################################################
# data_1_4_subnet_id - The VPC subnet ID for the F5 BIG-IQ 1.4 data interface
##################################################################################
variable "data_1_4_subnet_id" {
  type        = string
  default     = ""
  description = "Optional VPC Gen2 subnet ID for the F5 BIG-IQ 1.4 data network"
}

##################################################################################
# phone_home_url - The web hook URL to POST status to when F5 BIG-IQ onboarding completes
##################################################################################
variable "phone_home_url" {
  type        = string
  default     = ""
  description = "The URL to POST status when BIG-IQ is finished onboarding"
}

##################################################################################
# schematic template for phone_home_url_metadata
##################################################################################
variable "template_source" {
  default     = "f5devcentral/ibmcloud_schematics_bigiq_multinic"
  description = "The terraform template source for phone_home_url_metadata"
}
variable "template_version" {
  default     = "20200825"
  description = "The terraform template version for phone_home_url_metadata"
}
variable "app_id" {
  default     = "undefined"
  description = "The terraform application id for phone_home_url_metadata"
}

##################################################################################
# schematic template for license pool playbooks
##################################################################################
variable "license_type" {
  type        = string
  default     = "none"
  description = "How to license, may be 'none','bigiq_regkey','regkeypool','utilitypool'"
}

variable "license_pool_name" {
  type        = string
  default     = "none"
  description = "The name of the BIG-IP license pool to create"
}

variable "license_utility_regkey" {
  type        = string
  default     = "none"
  description = "The BIG-IP utility pool regkey to create offerings to grant"
}

variable "license_regkey_offerings" {
  type        = list(string)
  default     = []
  description = "List of regkey pool offerings"
}
