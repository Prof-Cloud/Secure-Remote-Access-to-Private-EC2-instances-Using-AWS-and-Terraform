#Windows Server (Bastion Host)
resource "aws_instance" "Bastion_Host" {
  ami           = data.aws_ami.Windows_ami.id
  instance_type = "t3.large"
  #Using existing Key Pair
  key_name                    = "ssh-key"
  subnet_id                   = aws_subnet.public_subnet[0].id
  associate_public_ip_address = true


vpc_security_group_ids = [aws_security_group.Windows_Server.id]

  tags = {
    Name = "Bastion Host"
  }
}

#Linux Server 
resource "aws_instance" "Linux" {
  ami           = data.aws_ami.linux_ami.id
  instance_type = "t3.micro"
  #Using existing Key Pair
  key_name                    = "ssh-key"
 subnet_id                   = aws_subnet.private_subnet[0].id
 user_data = "${file("userdata.sh")}"

vpc_security_group_ids = [aws_security_group.Linux_Server.id]

  tags = {
    Name = "Linux Server"
  }
}


