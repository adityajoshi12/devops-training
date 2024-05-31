
**Web Server Deployment**

*   Provision a virtual network with a public and private subnet.
*   Create a security group for a web server, allowing inbound HTTP and SSH traffic.
*   Launch a web server instance in the public subnet.
*   Deploy a simple static website (e.g., index.html with some basic content) to the web server.
*   Ensure the website is accessible through the public internet.

<details>
<summary>Solution</summary>

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
 region = "us-east-1" # Replace with your desired region
}

# Create VPC
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
}

# Create Public Subnet
resource "aws_subnet" "public" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.0.1.0/24"
 availability_zone = "us-east-1a" # Adjust availability zone as needed
}

# Create Private Subnet (Optional for this scenario)
resource "aws_subnet" "private" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.0.2.0/24"
 availability_zone = "us-east-1b" # Adjust availability zone as needed
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.main.id
}

# Connect Internet Gateway to VPC
resource "aws_route_table_association" "public_assoc" {
 subnet_id      = aws_subnet.public.id
 route_table_id = aws_route_table.public.id
}

# Create Public Route Table
resource "aws_route_table" "public" {
 vpc_id = aws_vpc.main.id

 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
}

# Create Security Group for Web Server
resource "aws_security_group" "webserver_sg" {
 name   = "webserver_sg"
 vpc_id = aws_vpc.main.id

 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"] # Limit this to your IP for better security
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

# Launch Web Server Instance
resource "aws_instance" "webserver" {
 ami           = "ami-09d95fab7fff3776c" # Replace with AMI ID for your region
 instance_type = "t2.micro"
 subnet_id     = aws_subnet.public.id
 security_groups = [aws_security_group.webserver_sg.id]

 # User data to install and configure webserver (example for Apache)
 user_data = <<-EOF
   #!/bin/bash
   yum update -y
   yum install -y httpd
   systemctl start httpd
   systemctl enable httpd
   echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
 EOF
 
 # You can use provisioner as well (remote-exec)
}

# Output the Public IP of the Web Server
output "webserver_public_ip" {
 value = aws_instance.webserver.public_ip
}
```

</details>




**Database Infrastructure**

*   Provision a virtual network with private subnets in multiple availability zones.
*   Create a security group for a database server, allowing access only from specific IP ranges or security groups.
*   Launch two database instances (e.g., MySQL, PostgreSQL) in separate availability zones for redundancy.
*   Test the failover mechanism to ensure database availability in case of an instance failure.

<details>
<summary>Solution</summary>

```terraform
# Configure the AWS Provider
provider "aws" {
 region = "us-east-1" # Replace with your desired region
}

# Create VPC
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
}

# Create Private Subnets in Different Availability Zones
resource "aws_subnet" "private_1" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.0.1.0/24"
 availability_zone = "us-east-1a" # Adjust availability zone as needed
}

resource "aws_subnet" "private_2" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.0.2.0/24"
 availability_zone = "us-east-1b" # Adjust availability zone as needed
}

# Create Security Group for Database Servers
resource "aws_security_group" "db_sg" {
 name   = "db_sg"
 vpc_id = aws_vpc.main.id

 ingress {
   from_port   = 3306 # Adjust port based on your database
   to_port     = 3306
   protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"] # Allow access within the VPC
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

# Launch Database Instances (Example for MySQL)
resource "aws_instance" "db_1" {
 ami           = "ami-09d95fab7fff3776c" # Replace with AMI ID for your region
 instance_type = "t2.micro"
 subnet_id     = aws_subnet.private_1.id
 security_groups = [aws_security_group.db_sg.id]

 # User data to install and configure database (replace with your specific setup)
 user_data = <<-EOF
   #!/bin/bash
   yum update -y
   yum install -y mysql-server
   systemctl start mysqld
   systemctl enable mysqld
   # Add your database configuration here
 EOF
}

resource "aws_instance" "db_2" {
 # Same configuration as db_1 but in different subnet
 # ...
 subnet_id     = aws_subnet.private_2.id 
}

# Configure Replication (This part requires specific configuration based on your database engine)
# Refer to the documentation for your chosen database for setting up replication 

# Output information about the database instances
output "db_1_private_ip" {
 value = aws_instance.db_1.private_ip
}

output "db_2_private_ip" {
 value = aws_instance.db_2.private_ip
}
```

</details>
