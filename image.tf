

locals {
  custom_image = var.bigiq_custom_image == "" ? 0 : 1
  public_image = var.bigiq_custom_image == "" ? 1 : 0
  image_id     = var.bigiq_custom_image == "" ? data.external.bigiq_public_image.0.result.image_id : data.ibm_is_image.bigiq_custom_image.0.id
}

data "ibm_is_image" "bigiq_custom_image" {
  count = local.custom_image
  name  = var.bigiq_image_name
}

data "external" "bigiq_public_image" {
  count   = local.public_image
  program = ["python3", "${path.module}/bigiq_image_selector.py"]
  query = {
    region         = var.region
    version_prefix = var.bigiq_image_name
  }
}