variable "region" {}
variable "vpc_cidr" {}

variable "pub-sub1-cidr" {}
variable "pub-sub2-cidr" {}
variable "security-group" {}
variable "az" {}
variable "pub-sub1-tag" {}
variable "pub-sub2-tag" {}
variable "vpc-tags" {}
  
variable "key-name" {}
variable "ec2-ami" {}
variable "instance-type" {}
#we add variables for subnets and security group for our instance to use them
variable "subnets" {
    type = list(string)
    default = ["aws_subnet.pub-sub1.id, aws_subnet.pub-sub2.id"]
}
variable "ec2-name" {
    type = list(string)
    default = ["ansible", "terraform"]
  
}

