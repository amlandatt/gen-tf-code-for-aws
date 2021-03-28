 variable "vpc_cidr_block" {
     type = string
    default = "10.130.116.0/22"
 }

variable "env_tags" { 
    type = map
    default = { 
    "gen/lob" = "general.it",
    "gen/product" = "application-group-name",
    "gen/stage" = "dev",
    "gen/shared" = "false"
    "cost" = "cost-center-of-product",
    "environment" = "dev",
    } 
}


# public subnet creation 
variable "count_of_public_subnets"{
    type = number
    default = 2
}

variable "gen_public_subnets_cidr"{
    type = list
    default = ["10.130.116.0/27" , "10.130.116.32/27"]
}

variable "gen_availability_zone_of_public_subnet"{
    type = list
    default = ["ap-south-1a" , "ap-south-1b"]
}


# private subnet creation 
variable "count_of_private_subnets"{
    type = number
    default = 2
}

variable "gen_private_subnets_cidr"{
    type = list
    default = ["10.130.116.128/26" , "10.130.116.192/26"]
}

variable "gen_availability_zone_of_private_subnet"{
    type = list
    default = ["ap-south-1a" , "ap-south-1b"]
}




variable "gen-bucket-name-1" { 
    type = string
    default = "s3-encrypted-bucket-testtt"
}

variable "endpoint_region" { 
    type = string
    default = "ap-south-1"
}


# ------ EC2 variables -------

variable "instance-count" { 
    type = number
    default = 2
}

variable "instance-file-path" { 
     type = string
     default = "../../modules/compute/ec2-user-files/app_server_userdata.sh"
  }

variable "instance-ami" { 
    type = string
    default = "ami-068d43a544160b7ef"
}

variable "instance-type" { 
    type = string
    default = "t2.micro"
}

variable "instance-private-ip" { 
    type = list
     default = ["10.130.116.10"  , "10.130.116.40" ]
}

variable "all-az" { 
    type = list
    default = ["ap-south-1a"  , "ap-south-1b"]
}

variable "my-key-name" { 
    type = string
    default = "aws_personal_ac_key"
}

variable "root-volume-type" { 
    type = string
    default = "gp2"
}

variable "root-volume-size" { 
    type = number
    default = 10
}


variable ebs_block_device { 
      type = list(map(string))
# In case of no extra ebs block device , defailt value should be ..
/*
 default = [
 ]
*/
 default =   [ 
  {
   addl-disk-name = "/dev/xvdb"
   addl-disk-type = "gp2"
   addl-disk-size =  5
  } ,
  {
  addl-disk-name = "/dev/xvdc"
   addl-disk-type = "gp2"
   addl-disk-size =  4
  }
  ]
 
  }

variable "ec2-instance-name" { 
    type = string
    default = "gen-app-server"
}