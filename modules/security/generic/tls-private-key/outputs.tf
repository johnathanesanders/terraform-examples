output "id" {
    value = tls_private_key.ssh_key.id
}

output "private_key_openssh" {
    value = tls_private_key.ssh_key.private_key_openssh
}

output "private_key_pem" {
    value = tls_private_key.ssh_key.private_key_pem
}

output "private_key_pem_pkcs8" {
    value = tls_private_key.ssh_key.private_key_pem_pkcs8
}

output "public_key_fingerprint_md5" {
    value = tls_private_key.ssh_key.public_key_fingerprint_md5
}

output "public_key_fingerprint_sha256" {
    value = tls_private_key.ssh_key.public_key_fingerprint_sha256
}

output "public_key_openssh" {
    value = tls_private_key.ssh_key.public_key_openssh
}

output "public_key_pem" {
    value = tls_private_key.ssh_key.public_key_pem
}

