output "public_subnet_rt_id" {
  value = aws_route_table.gen_public_subnet_route_table.id
}


output "private_subnet_rt_id" {
  value = aws_route_table.gen_private_subnet_route_table.id
}
