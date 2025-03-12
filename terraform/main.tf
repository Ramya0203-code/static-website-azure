terraform {
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
  }
  
  provider "azurerm" {
    features {}
  }
  
  resource "azurerm_resource_group" "static_site_rg" {
    name     = "static-website-rg"
    location = "East US"
  }
  
  resource "azurerm_storage_account" "static_site_storage" {
    name                     = "staticwebsitestorage"
    resource_group_name      = azurerm_resource_group.static_site_rg.name
    location                 = azurerm_resource_group.static_site_rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    static_website {
      index_document = "index.html"
    }
  }
  
  resource "azurerm_storage_blob" "index_html" {
    name                   = "index.html"
    storage_account_name   = azurerm_storage_account.static_site_storage.name
    storage_container_name = "$web"
    type                   = "Block"
    source                 = "../index.html"
  }
  