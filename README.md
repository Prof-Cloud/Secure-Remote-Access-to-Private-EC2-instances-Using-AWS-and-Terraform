## AWS Bastion Host-Secure Remote Access to Your Private Instance

In this project, I created a Bastion Host within a custom VPC, allowing me to securely connect to a private Linux EC2 instance that is not accessible from the internet. The Bastion Host is a Windows server in the public subnet, and I use it to RDP in and then SSH into the Linus server. I also built the entire network, including the VPC, subnets, Internet Gateway, NAT Gateway, route tables, and security groups.

