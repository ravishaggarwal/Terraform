variable "vpcid_subnet" {
  description = "The cidr_block "
  default = ""
}

variable "createdIGW" {
  description = "The cidr_block "
  default = ""
}

variable "all_subnet_ids" {
  description = "The cidr_block "
  type = "list"
}

variable "subnet_Count" {
  description = "The cidr_block "
  default = ""
}



variable "defaultRouteTableId" {
  description = "The cidr_block "
  default = ""
}

variable "env"{
  default = ""
}
