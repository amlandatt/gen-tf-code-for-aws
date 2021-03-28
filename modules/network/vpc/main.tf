# One VPC creation

 resource "aws_vpc" "gen_vpc" {
  cidr_block           = var.vpc_cidr_block
  tags = merge(map("Name", "gen-vpc-${var.env_tags.environment}"), var.env_tags)
 }