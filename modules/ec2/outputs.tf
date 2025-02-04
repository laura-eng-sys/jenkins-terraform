output "key-name" {
  value = var.key-name
}

output "ec2-ami" {
  value =  var.ec2-ami
}

output "instance-type" {
  value = var.instance-type
}
#we add outputs for subnets and security group for our instance to use them
#for multiples values, we can just use variables
#output "subnets" {
    #value =aws_subnet.public_subnet_az1.id
  
#}

output "security-group_id" {
    value = "aws_security_group.ec2_sg.id"  
  
}

output "key-pair" {
    value = "aws_key_pair.key-pair.key_name"
  
}
