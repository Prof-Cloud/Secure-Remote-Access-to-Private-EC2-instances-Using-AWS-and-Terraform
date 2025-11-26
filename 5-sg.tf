#Securitty Group For Windows Server (Bastion Host)

resource "aws_security_group" "Windows_Server" {
  name        = "Windows_Server"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Prof_Cloud_VPC.id
  tags = {
    Name = "Windows Server SG"
  }
}

#Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "Windows_Server_rdp" {
  security_group_id = aws_security_group.Windows_Server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

#Outbound Rules
resource "aws_vpc_security_group_egress_rule" "Windows_Server_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Windows_Server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


#Securitty Group For Linux Server 

resource "aws_security_group" "Linux_Server" {
  name        = "Linux_Server"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Prof_Cloud_VPC.id

  tags = {
    Name = "Linux Server SG"
  }
}

#Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_ipv4" {
  security_group_id = aws_security_group.Linux_Server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "Linux_Server_ssh" {
  security_group_id = aws_security_group.Linux_Server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

#Allow ICMP (ping) from Windows Server SG
resource "aws_vpc_security_group_ingress_rule" "Linux_Server_icmp_from_windows" {
  security_group_id            = aws_security_group.Linux_Server.id
  referenced_security_group_id = aws_security_group.Windows_Server.id

  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1
}


#Outbound Rules
resource "aws_vpc_security_group_egress_rule" "Linux_Server_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Linux_Server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

