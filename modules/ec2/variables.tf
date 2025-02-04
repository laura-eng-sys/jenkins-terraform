variable "key-name" {}
variable "ec2-ami" {}
variable "instance-type" {}
#we add variables for subnets and security group for our instance to use them
variable "subnets" {
    type = list(string)
    default = ["aws_subnet.pub-sub1.id", "aws_subnet.pub-sub2.id"]
}
variable "security-group" {}
variable "ec2-name" {
    type = list(string)
    default = ["ansible", "terraform"]
  
}
