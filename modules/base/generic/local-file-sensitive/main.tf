resource "local_sensitive_file" "sensitive_file" {
    content = var.content != null ? var.content : null
    content_base64 = var.content_base64 != null ? var.content_base64 : null
    filename = var.filename
    directory_permission = var.directory_permission
    file_permission = var.file_permission
    source = var.sourcefile != null ? var.sourcefile : null
}