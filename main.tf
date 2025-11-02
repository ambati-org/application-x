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
      name = "dev"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-1"
  location = "eastus"
  tags   = {"env" = "dev" } 
}
