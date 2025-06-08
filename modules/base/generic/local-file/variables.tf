variable "content" {
    default = null
    description = "The content of the file."
    nullable = true
    type = string
}

variable "content_base64" {
    default = null
    description = "The base64 encoded content of the file."
    nullable = true
    type = string
}

variable "directory_permission" {
    default = "0777"
    description = "The permission of the directory."
    nullable = true
    type = string
}

variable "file_permission" {
    default = "0777"
    description = "The permission of the file."
    nullable = true
    type = string
}

variable "filename" {
    description = "The name of the file."
    type = string
}

variable "sourcefile" {
    default = null
    description = "The path to the source file."
    nullable = true
    type = string
}