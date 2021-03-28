variable "vpc_id" { 
    type = string
}

variable "count_of_specific_type_subnets" { 
    type = number
}

variable "cidr_block_of_subnet" { 
    type = list
}

variable "availability_zone_of_subnet" { 
    type = list
}
variable "public_ip_status" { 
    type = bool
}

 variable "subnet_name" { 
    type = string
 }

 variable "route_table_id" { 
    type = string
 }