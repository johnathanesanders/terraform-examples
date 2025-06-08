# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = ""
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

provider "local" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}
