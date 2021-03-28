 output "subnetid" {
  value = aws_subnet.gen_subnet[*].id
 }
