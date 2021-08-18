variable "TerraformRGName" {
  type = string
  default = "Terraform_RG"
}

variable "TerraformLocation"{
    type = string
    default = "West Europe"
}

variable "TerraformASName"{
    type = string
    default = "TerraformAppServiceName"
}

variable "TerraformDemoAppName" {
  type = string
  default = "TerraformDemoApp"
}

variable "TerraformSA"{
    type = string
    default = "TerraformStorageAccount"
}

variable "sqlservername" {
  type = string
  default = "SqlServer"
}

variable "sqldatabasename" {
  type = string
  default = "SqlDatabase"
}