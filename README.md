# AWS Bastion Host-Secure Remote Access to Your Private Instance

In this project, I created a Bastion Host within a custom VPC, allowing me to securely connect to a private Linux EC2 instance that is not accessible from the internet. The Bastion Host is a Windows server in the public subnet, and I use it to RDP in and then SSH into the Linus server. I also built the entire network using Terraform, including the VPC, subnets, Internet Gateway, NAT Gateway, route tables, and security groups.

<img width="3669" height="1160" alt="Blank diagram (2)" src="https://github.com/user-attachments/assets/edd6eea4-2740-46c9-a285-e06b7183d1c0" />



## What I Built

1. Custom VPC - I created a custom VPC using a CIDR range that I chose. Inside this, I made:
  - public subnets
  - private subnets

2. Internet Gateway - I made an Internet gateway and attached it to the VPC so anything in the public subnet (like the Badtion Host) can reach the Internet.

3. NAT Gateway - I created a NAT gateway in the public subnet and attached an Elastic IP to it. This lets the private Linux server connect outbound to the internet, but it still stay hidden and cannot be reached from the outside.

4. Route tables - I made 2 different route tables:
    - Public Route Table
        - Sends all traffic to the Internet Gateway
        - Connected to the public subnets
          
    - Private Route Table
        - Sends all traffic to the NAT Gateway
        - Connected to the private subnets

5. Security Groups - I made separate security groups for each server:
    - Windows Server (Bastion Host)
        - Allow RDP (port 3389)
        
    - Linus Server (Private Server)
        - Allow SSH (port 22)
        - Allow HTTP (port 80)
        - Allow ICMP from Windows Server (Bastion Host)
          
6. EC2 Instances
   - Windows Server (Bastion Host)
       - Lives in a public subnet
       - Has a Public IP

   -  Linus Server (Private Server)
       - Lives in a private subnet
       - Has no public IP
       - Has userdata to install updates or packages on startup
       - Hidden from the internet

  ## Alternatives You Could Use Instead

  1. AWS Systems Manager
       - No Bastion Host needed
       - NO open ports
       - Connect through AWS Console or CLI
       - Centralized access control to managed nodes using IAM policies
         
  2. AWS Client VPN
      - Creates a secure tunnel from your laptop to the VPC
      - Works like being in the cloud network

  3. Zero-Trust Tools
       - Teleport, Cloudflare Access, etc
       - MFA
       - Identity-based access
       - Strong Audit Logs

## IMprovements I Can Add Later

1. Limit SSH so that only the Bastion Host can reach the Linux server
2. Add MFA to the Bastion Host
3. Turn on logging for better auditing




