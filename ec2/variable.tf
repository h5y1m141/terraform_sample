variable "public_subnet_id" {
  description = "set subnet id"
}
variable "private_subnet_id" {
  description = "set subnet id"
}
variable "key_name" {
  description = "Desired name of AWS key pair"
}
variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}
variable "security_group_ssh" {
  description = "select security group ssh"
}
