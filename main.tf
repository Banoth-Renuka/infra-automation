# main.tf

# --- 1️⃣ VPC ---
resource "aws_vpc" "mycustom_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "mycustom_vpc" }
}

# --- 2️⃣ Internet Gateway ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mycustom_vpc.id

  tags = { Name = "main-igw" }
}

# --- 3️⃣ Public Subnets ---
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.mycustom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az1" }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.mycustom_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-az2" }
}

# --- 4️⃣ Private Subnets ---
resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.mycustom_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
  tags = { Name = "private-subnet-az1" }
}

resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.mycustom_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  tags = { Name = "private-subnet-az2" }
}

# --- 5️⃣ Public Route Table ---
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mycustom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-route-table" }
}

# Associate public subnets
resource "aws_route_table_association" "public_assoc_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_rt.id
}

# --- 6️⃣ Private Route Table ---
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.mycustom_vpc.id
  tags   = { Name = "private-route-table" }
}

# Associate private subnets
resource "aws_route_table_association" "private_assoc_az1" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_az2" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.private_rt.id
}

# --- 7️⃣ Security Group ---
resource "aws_security_group" "web_sg" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.mycustom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "web-sg" }
}

# --- 8️⃣ AWS Key Pair ---
resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# --- 9️⃣ EC2 Instance ---
resource "aws_instance" "web_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tf_key.key_name
  subnet_id                   = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>Hello from Terraform in ap-south-1a!</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "web-server-az1" }
}
