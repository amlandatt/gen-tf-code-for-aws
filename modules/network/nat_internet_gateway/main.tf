# General Internet Gateway 
resource "aws_internet_gateway" "gen_igw" {
  vpc_id = var.vpc_id
  tags = { Name = "gen_internet_gateway" }

}

# Internet Gateway Route table
resource "aws_route_table" "gen_public_subnet_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gen_igw.id
  }
  tags = { Name = "gen_public_subnet_route_table" }
}



### Common NAT GW creation Begin
# Elastic IP for  NAT Gateway 
resource "aws_eip" "common_nat_gateway_eip" {
      vpc     = true
      tags    =  { Name = "common_nat_gateway_eip" }
}

# NAT Gateway 
resource "aws_nat_gateway" "common_nat_gateway" {
      allocation_id    = aws_eip.common_nat_gateway_eip.id
      subnet_id        = var.subnet_for_natgateway
      tags             = { Name = "common_nat_gateway" }
}

# Route table for common NAT Gateway
resource "aws_route_table" "gen_private_subnet_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.common_nat_gateway.id
  }
  tags = { Name = "gen_private_subnet_route_table" }
}