terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    organization = "ambati-org"

    workspaces {
      tags = ["project:alpha"]
    }
  }
}

provider "azurerm" {
  features {}
}