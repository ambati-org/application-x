locals {
  prod = {
    keyvault_name = "ambatitestkv007"

    tags = {
      terraform_repo = "myrepo"
    }
  }
}
