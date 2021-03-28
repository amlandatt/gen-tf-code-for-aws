resource "aws_subnet" "gen_subnet" {
  count                   = var.count_of_specific_type_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.cidr_block_of_subnet, count.index)
  availability_zone       = element(var.availability_zone_of_subnet, count.index)
  map_public_ip_on_launch = var.public_ip_status
  tags =  { Name = "${var.subnet_name}-az${count.index + 1}" }

}
# Associate   Subnet to route table

resource "aws_route_table_association" "route_table_association" {
  count          =  var.count_of_specific_type_subnets
  subnet_id      =  element(aws_subnet.gen_subnet.*.id, count.index)
  route_table_id = var.route_table_id
}

