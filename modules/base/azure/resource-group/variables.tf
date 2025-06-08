variable "location" {
    description = "Location of the resource group"
    type = string
}

variable "managed_by" {
    default = null
    description = "(Optional) The ID of the resource or application that manages this Resource Group."
    nullable = true
    type = string
}

variable "name" {
    description = "Name of the resource group"
    type = string
}

variable "tags" {  
    default = null
    description = "Tags to be applied to the resource group"
    nullable = true
    type = map(string)
}