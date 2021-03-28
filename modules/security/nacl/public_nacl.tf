# NACL needs to be created for each group of subnets
# This one is for public subnets

resource "aws_network_acl" "gen-public-subnet-nacl" {
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  
 # Ingress for HTTPs port

 ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
    
 # Ingress for ephemeral ports

   ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

 # Ingress for HTTP port
 ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block =  "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

 #----egress rules----#

 # Egress for HTTPs port
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  } 

# egress for ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

# Egress for HTTP port
  
egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80 
    to_port    = 80
  }

  
  tags = { Name = "gen_public_nacl" }
 
} # end resource
