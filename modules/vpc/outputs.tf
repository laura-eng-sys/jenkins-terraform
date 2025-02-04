output "security_group_id" {
  value = aws_security_group.ec2_sg.id
  
}

output "pub-sub1-id" {
  value = aws_subnet.pub-sub1.id 
  
}
output "pub-sub2-id" {
  value = aws_subnet.pub-sub2.id 
  
}
