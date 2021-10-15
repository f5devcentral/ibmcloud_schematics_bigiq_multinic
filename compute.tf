# lookup SSH public keys by name
data "ibm_is_ssh_key" "ssh_pub_key" {
  name = var.ssh_key_name
}

# lookup compute profile by name
data "ibm_is_instance_profile" "instance_profile" {
  name = var.instance_profile
}

# create a random password if we need it
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

locals {
  # set the user_data YAML template for each license type
  license_map = {
    "none"         = file("${path.module}/user_data_no_license.yaml")
    "bigiq_regkey" = file("${path.module}/user_data_license_only.yaml")
    "regkeypool"   = file("${path.module}/user_data_license_regkey_pool.yaml")
    "utilitypool"  = file("${path.module}/user_data_license_utility_pool.yaml")
  }
}

locals {
  template_file = lookup(local.license_map, var.license_type, local.license_map["none"])
  # user admin_password if supplied, else set a random password
  admin_password = var.bigiq_admin_password == "" ? random_password.password.result : var.bigiq_admin_password
  # set user_data YAML values or else set them to null for templating
  phone_home_url         = var.phone_home_url == "" ? "null" : var.phone_home_url
  license_basekey        = var.license_basekey == "none" ? "null" : var.license_basekey
  license_pool_name      = var.license_pool_name == "none" ? "null" : var.license_pool_name
  license_utility_regkey = var.license_utility_regkey == "none" ? "null" : var.license_utility_regkey
}

data "template_file" "user_data" {
  template = local.template_file
  vars = {
    bigiq_admin_password   = local.admin_password
    license_basekey        = local.license_basekey
    license_pool_name      = local.license_pool_name
    license_utility_regkey = local.license_utility_regkey
    license_regkeys        = join(", ", var.license_regkey_offerings)
    phone_home_url         = local.phone_home_url
    template_source        = var.template_source
    template_version       = var.template_version
    zone                   = data.ibm_is_subnet.f5_managment_subnet.zone
    vpc                    = data.ibm_is_subnet.f5_managment_subnet.vpc
    app_id                 = var.app_id
  }
}

# create compute instance
resource "ibm_is_instance" "f5_bigiq_instance" {
  name    = var.instance_name
  image   = local.image_id
  profile = data.ibm_is_instance_profile.instance_profile.id
  primary_network_interface {
    name            = "management"
    subnet          = data.ibm_is_subnet.f5_managment_subnet.id
    security_groups = [ibm_is_security_group.f5_open_sg.id]
  }
  dynamic "network_interfaces" {
    for_each = local.secondary_subnets
    content {
      name            = format("data-1-%d", (network_interfaces.key + 1))
      subnet          = network_interfaces.value
      security_groups = [ibm_is_security_group.f5_open_sg.id]
    }

  }
  vpc        = data.ibm_is_subnet.f5_managment_subnet.vpc
  zone       = data.ibm_is_subnet.f5_managment_subnet.zone
  keys       = [data.ibm_is_ssh_key.ssh_pub_key.id]
  user_data  = data.template_file.user_data.rendered
  depends_on = [ibm_is_security_group_rule.f5_allow_outbound]
}

# create floating IP for management access
resource "ibm_is_floating_ip" "f5_management_floating_ip" {
  name   = "f0-${random_uuid.namer.result}"
  target = ibm_is_instance.f5_bigiq_instance.primary_network_interface.0.id
}
