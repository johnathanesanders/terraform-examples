output "content_base64sha256" {
    description = "The SHA256 hash of the base64 encoded content."
    value = local_sensitive_file.sensitive_file.content_base64sha256
}

output "content_base64sha512" {
    description = "The SHA512 hash of the content."
    value = local_sensitive_file.sensitive_file.content_base64sha512
}

output "content_md5" {
    description = "The MD5 hash of the content."
    value = local_sensitive_file.sensitive_file.content_md5
}

output "content_sha1" {
    description = "The SHA1 hash of the content."
    value = local_sensitive_file.sensitive_file.content_sha1
}

output "content_sha256" {
    description = "The SHA256 hash of the content."
    value = local_sensitive_file.sensitive_file.content_sha256
}

output "content_sha512" {
    description = "The SHA512 hash of the content."
    value = local_sensitive_file.sensitive_file.content_sha512
}

output "filename" {
    description = "The name and location of the sensitive_file."
    value = local_sensitive_file.sensitive_file.filename
}

output "id" {
    description = "The hexadecimal encoding of the SHA1 checksum of the sensitive_file content."
    value = local_sensitive_file.sensitive_file.id
}