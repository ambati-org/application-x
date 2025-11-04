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

resource "azurerm_resource_group" "example" {
  name     = "rg-example-1"
  location = "eastus"
  tags     = { "env" = "dev" }
}


module "vars" {
  source      = "./vars"
  environment = var.environment
}


resource "azurerm_resource_group" "test" {
  name     = "rg-example-2"
  location = "eastus"
  tags     = { "env" = module.vars.env.environment }
}