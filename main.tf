# Creating Azure Resource Group

resource "azurerm_resource_group" "terraform_resource_group" {
    name = "${var.TerraformRGName}"
    location = "${var.TerraformLocation}"
}

# ================================================================================================================

# Creating Azure Storage Account

resource "azurerm_storage_account" "terraform_storage_account" {
  name                     = "${var.TerraformSA}"
  resource_group_name      = "${var.TerraformRGName}"
  location                 = "${var.TerraformLocation}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# ================================================================================================================

# Creating Azure App Service Plan

resource "azurerm_app_service_plan" "terraform_app_service" {
  name                = "${var.TerraformASName}"
  location            = "${var.TerraformLocation}"
  resource_group_name = "${var.TerraformRGName}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# ================================================================================================================

# Creating Azure App Service

resource "azurerm_app_service" "terraform_demo_app_service" {
  name                = "${var.TerraformDemoAppName}"
  location            = "${var.TerraformLocation}"
  resource_group_name = "${var.TerraformRGName}"
  app_service_plan_id = azurerm_app_service_plan.terraform_app_service.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

# ================================================================================================================

# Creating SQL Server

resource "azurerm_sql_server" "terraformsqlserver" {
  name                         = "${var.sqlservername}"
  resource_group_name          = "${var.TerraformRGName}"
  location                     = "${var.TerraformLocation}"
  version                      = "12.0"
  administrator_login          = "admin"
  administrator_login_password = "admin01"
}

resource "azurerm_sql_database" "sqldatabase" {
  name                          = "${var.sqldatabasename}"
  resource_group_name           = "${var.TerraformRGName}"
  location                      = "${var.TerraformLocation}"
  server_name                   = "${azurerm_sql_server.terraformsqlserver.name}"


  tags = {
      environment = "production"
  } 
}

# ================================================================================================================