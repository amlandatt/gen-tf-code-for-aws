# Main for dev
provider "aws" {
   region = "ap-south-1"
 }

provider "aws" {
   alias = "dr-region"
   region = "us-east-1"
 }

terraform {
  required_version = ">= 0.13.4"
}

module "general-vpc" {
  source                  = "../../modules/network/vpc"
   vpc_cidr_block          = var.vpc_cidr_block
   env_tags                = var.env_tags
}

/* DR regions can be created in following way

module "general-vpc-dr" {
   source                  = "../../modules/network/vpc"
    providers = {
    aws = "aws.dr-region"
   }
   vpc_cidr_block          = var.vpc_cidr_block
   env_tags                = var.env_tags
}

*/

module "general-nat-internet-gateway" {
   source                            = "../../modules/network/nat_internet_gateway"
   vpc_id                            = module.general-vpc.vpcid
   subnet_for_natgateway             = module.general-public-subnet.subnetid[0]
}

module "general-nacl" {
   source                            = "../../modules/security/nacl"
   vpc_id                            = module.general-vpc.vpcid
   subnet_ids                        = module.general-public-subnet.subnetid[*]
}

module "security-groups" {
   source                            = "../../modules/security/security-groups"
   vpc_id                            = module.general-vpc.vpcid
  
}

module "general-public-subnet" {
  source                  = "../../modules/network/subnet"
   count_of_specific_type_subnets    = var.count_of_public_subnets
   vpc_id                            = module.general-vpc.vpcid
   cidr_block_of_subnet              = var.gen_public_subnets_cidr
   availability_zone_of_subnet       = var.gen_availability_zone_of_public_subnet
   public_ip_status                  = true
   route_table_id                   =  module.general-nat-internet-gateway.public_subnet_rt_id
   subnet_name                       = "gen-public-subnet"
}


module "general-private-subnet" {
  source                  = "../../modules/network/subnet"
   count_of_specific_type_subnets    = var.count_of_private_subnets
   vpc_id                            = module.general-vpc.vpcid
   cidr_block_of_subnet              = var.gen_private_subnets_cidr
   availability_zone_of_subnet       = var.gen_availability_zone_of_private_subnet
   public_ip_status                  = false
   route_table_id                    = module.general-nat-internet-gateway.private_subnet_rt_id
   subnet_name                       = "gen-private-subnet"
}


module "gen-s3-bucket" {
   source                            = "../../modules/storage/s3"
   bucket-name                       = var.gen-bucket-name-1
   vpc_id                            = module.general-vpc.vpcid
   endpoint_region                   = var.endpoint_region
   route-table-id                    = module.general-nat-internet-gateway.private_subnet_rt_id
   
  }


module "app-server" {
   source                            = "../../modules/compute/ec2"
   instance-count                    = var.instance-count
   instance-file-path                = var.instance-file-path  
   instance-ami                      = var.instance-ami 
   instance-type                     = var.instance-type
   instance-private-ip               = var.instance-private-ip
   all-az                            = var.all-az 
   all-subnets-id                    = module.general-public-subnet.subnetid
 // For specific subnet , use following format
 // all-subnets-id                    = [ module.general-public-subnet.subnetid[0] , module.general-public-subnet.subnetid[1]]
   security-group-id                 = module.security-groups.linux_sg_id
   my-key-name                       = var.my-key-name
   root-volume-type                  = var.root-volume-type
   root-volume-size                  = var.root-volume-size
   ebs_block_device                  = var.ebs_block_device
   ec2-instance-name                 = var.ec2-instance-name
}


