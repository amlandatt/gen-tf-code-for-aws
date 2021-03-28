
variable "instance-count" { 
    type = number
}

variable "instance-file-path" { 
    type = string
}

variable "instance-ami" { 
    type = string
}

variable "instance-type" { 
    type = string
}

variable "instance-private-ip" { 
    type = list
}

variable "all-az" { 
    type = list
}

variable "all-subnets-id" { 
    type = list
}

variable "security-group-id" { 
    type = string
}

variable "my-key-name" { 
    type = string
}

variable "root-volume-type" { 
    type = string
}

variable "root-volume-size" { 
    type = number
}

variable "ebs_block_device" {
  type = list(map(string))
}

variable "ec2-instance-name" { 
    type = string
}