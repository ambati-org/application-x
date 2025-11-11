locals {
  prod = {
    # keyvault_name = "ambatitestkv009"

    tags = {
      terraform_repo = "myrepo"
      cost_center    = "10294"

    }
  }
}
