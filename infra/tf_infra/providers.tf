terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "servian_coreinfra"
    storage_account_name = "serviantfbackend"
    container_name       = "serviantfbackend"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {    
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

