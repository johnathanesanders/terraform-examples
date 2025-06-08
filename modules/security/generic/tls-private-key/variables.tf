variable "algorithm" {
    default = "RSA"
    description = "The algorithm to use. Valid values are RSA and ECDSA."
    type = string
}

variable "ecdsa_curve" {
    default = null
    description = "The elliptic curve to use. Valid values are P256, P384, and P521."
    nullable = true
    type = string
}

variable "rsa_bits" {
    default = 4096
    description = "The number of bits in the RSA key. Valid values are 1024, 2048, 3072, and 4096."
    type = number
}