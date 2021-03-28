
resource "aws_security_group" "linux_instance_sg" {
  
  vpc_id = var.vpc_id
 
 
    ingress {
    description = "RDP to Admin Subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = { Name = "gen_linux_sg" }
}
