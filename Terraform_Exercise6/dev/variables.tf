variable "env_value"{
  description = "choose env:  dev or prod"
}

variable "cidr_block" {
  description = "The cidr_block "
  type = "map"
  default = {
    dev = "198.18.0.0/16"
    prod = "198.18.0.0/16"
    }
}

variable "region" {
  description = "The region name"
  default = "us-east-1"
}

#variable "cidr_block" {
#  description = "The cidr_block "
#  default = "198.18.0.0/16"
#}

variable "vpcid_subnet" {
  description = "The cidr_block "
  default = ""
}

variable "cidrblock_subnet" {
  description = "The cidr_block "
  default = ""
}
