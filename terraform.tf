terraform {
  required_version = ">= 1.5.0"

  backend "remote" {
    organization = "ambati-org"

    workspaces {
      name = "dev"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}


