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

module "vars" {
  source      = "./vars"
  environment = var.environment
}


resource "azurerm_resource_group" "test" {
  name     = "rg-${var.environment}"
  location = "eastus"
  tags = merge(
    {
      env = var.environment
    },
    module.vars.env.tags
  )
}