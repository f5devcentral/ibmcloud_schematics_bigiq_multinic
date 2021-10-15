output "resource_name" {
  value = ibm_is_instance.f5_bigiq_instance.name
}

output "resource_status" {
  value = ibm_is_instance.f5_bigiq_instance.status
}

output "VPC" {
  value = ibm_is_instance.f5_bigiq_instance.vpc
}

output "image_id" {
  value = local.image_id
}

output "instance_id" {
  value = ibm_is_instance.f5_bigiq_instance.id
}

output "profile_id" {
  value = data.ibm_is_instance_profile.instance_profile.id
}

output "f5_shell_access" {
  value = "ssh://root@${ibm_is_floating_ip.f5_management_floating_ip.address}"
}

output "f5_phone_home_url" {
  value = var.phone_home_url
}