locals {
  data_infrastructure = {
    ari = azurerm_cosmosdb_account.main.id
  }
  data_authentication = {
    username = "${var.md_metadata.name_prefix}"
    password = azurerm_cosmosdb_account.main.primary_key
    hostname = "https://${var.md_metadata.name_prefix}.documents.cosmos.azure.com"
    port     = 443
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "cosmosdb_sql_authentication"
  provider_resource_id = azurerm_cosmosdb_account.main.id
  name                 = "CosmosDB SQL Server ${var.md_metadata.name_prefix} (${azurerm_cosmosdb_account.main.id})"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.data_authentication
      }
      specs = {
        azure = {
          region = azurerm_cosmosdb_account.main.location
        }
      }
    }
  )
}
