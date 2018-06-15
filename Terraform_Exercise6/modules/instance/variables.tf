variable "key_name" {
  default ="myec2sample"
}

variable "public_key_path" {
    default =""
}

variable "all_subnet_ids" {
  description = "The cidr_block "
  type = "list"
}
variable "SecurityGroupName" {
  default = ""
}

variable "env"{
  default = ""
}

#variable "SecurityGroupName" {
#  type = "list"
#}
