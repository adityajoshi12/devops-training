terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "my-rg" {
  name     = var.rg_name
  location = var.rg_region
  tags     = var.my-tags
}


