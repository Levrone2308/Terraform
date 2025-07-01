resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"
  description = "Security group for Dove instance"
  tags = {
    Name = "dove-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4       = "152.58.130.254/32" # Replace with your IP address
  ip_protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4       = "0.0.0.0/0" # Allow HTTP from anywhere
  ip_protocol          = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4       = "0.0.0.0/0"  
  ip_protocol = "-1" # -1 means all protocols
}
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv6" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv6       = "::/0"  # Allow all outbound IPv6 traffic
  ip_protocol = "-1" # -1 means all protocols
}
