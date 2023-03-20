# locals {
#     az_public = zipmap(local.azs, var.public_subnets)
#     az_private = zipmap(local.azs, var.private_subnets)
#     az_database = zipmap(local.azs, var.database_subnets)
# }

locals {

  name_suffix = "${var.project}-${var.environment}-${var.lab_number}"

}