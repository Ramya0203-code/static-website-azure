output "static_website_url" {
  value = "https://${azurerm_storage_account.static_storage.primary_web_host}"
}
