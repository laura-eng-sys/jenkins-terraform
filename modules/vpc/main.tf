#create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = var.vpc-tags

}#create internet gateway that will expose our public subnet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "igw"
    }
}

resource "aws_subnet" "pub-sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub-sub1-cidr
  availability_zone = var.az[0]
  tags = {
    Name = var.pub-sub1-tag
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub-sub2-cidr
  availability_zone = var.az[1]
  tags = {
    Name = var.pub-sub2-tag
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub-route-table"
  }
}


#association of public subnets to route table
resource "aws_route_table_association" "ass-pub1-route-table1" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "ass-pub2-route-table1" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.public-route-table.id
}

  

resource "aws_security_group" "ec2_sg" {
  name        = "security group for ec2 using terraform"
  description = "security group for ec2 using terraform"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "sg-ec2"
  }

#accept incomming traffic from anywhere, any ip address(reason why we put [0.0.0.0/0] and [::/0])
ingress{
  description = "https"
  from_port        = 443
  protocol         = "tcp"
  to_port          = 443
  cidr_blocks      =   ["0.0.0.0/0"]
}
ingress{
  description = "http"
  from_port        = 80
  protocol         = "tcp"
  to_port          = 80
  cidr_blocks      =   ["0.0.0.0/0"]
}
#port used to access virtual machine that we created
ingress{
  description = "ssh"
  from_port        = 22
  protocol         = "tcp"
  to_port          = 22
  cidr_blocks      =   ["0.0.0.0/0"]
}

egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1" # semantically equivalent to all ports
  cidr_blocks      =   ["0.0.0.0/0"]
}

}

