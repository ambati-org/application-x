# External variable required to use this module
variable "environment" {
  description = "The environment for fetching variables"
  type        = string
}

# List of all environments as a local module map
locals {
  environments = {
    dev  = local.dev
    uat  = local.uat
    prod = local.prod
  }
}

output "env" {
  value = local.environments[var.environment]
}
