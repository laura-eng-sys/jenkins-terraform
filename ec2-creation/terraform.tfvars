region = "us-east-1"
vpc_cidr = "192.168.0.0/26"
ec2-ami = "ami-04b70fa74e45c3917"
instance-type = "t2.micro"
key-name = "mykey"
pub-sub1-cidr = "192.168.0.0/27"
pub-sub2-cidr = "192.168.0.32/27"
az = ["us-east-1a", "us-east-1b"]
pub-sub1-tag = "pub-sub1"
pub-sub2-tag = "pub-sub2"
vpc-tags = {
  Name = "myvpc"
}
security-group = "aws_security_group.ec2_sg.id"



