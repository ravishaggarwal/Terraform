variable "env_value"{
  default = "dev"
  description = ""
}

variable "access_key" {
  description = "The access key for AWS login"
  default     = "" }
variable "secret_key" {
  description = "The secret key for AWS login"
  default     = "" }

variable "region" {
  description = "The region name"
  default = "us-east-1"
}

variable "cidr_block" {
  description = "The cidr_block "
  default = "198.18.0.0/16"
}
