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

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
}

data "azurerm_client_config" "this" {}

module "keyvault" {
  count   = var.environment == "dev" || var.environment == "prod" ? 1 : 0
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.2"

  location                 = azurerm_resource_group.test.location
  name                     = module.vars.env.keyvault_name
  resource_group_name      = azurerm_resource_group.test.name
  tenant_id                = data.azurerm_client_config.this.tenant_id
  enable_telemetry         = false
  purge_protection_enabled = false
}



