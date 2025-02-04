#generate the pem file for our key pair

resource "tls_private_key" "pem-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#create a key pair

resource "aws_key_pair" "key-pair" {
  key_name   = var.key-name
  public_key = tls_private_key.pem-key.public_key_openssh
}
#now we need to store our private key in our local machine and this will help us to access the machine we created through ssh. therefore, we will create a local file resource in which we will store our private key.go local_file | Resources | hashicorp/local
resource "local_file" "pri-key" {
  content = tls_private_key.pem-key.private_key_pem 
  filename = "${var.key-name}.pem"
}

resource "aws_instance" "public-ec2" {
  ami           = var.ec2-ami
  count= 2
  instance_type = var.instance-type
  key_name = aws_key_pair.key-pair.key_name #attach our key pair to our instance
  subnet_id = var.subnets[count.index]                           #attach our instance to the subnet
  associate_public_ip_address = true
  vpc_security_group_ids = var.security-group
    
  #user_data = file(shell_script_install_jenkins.sh) we cooment this out because we will not use. if we use it, the command in the script to show us jenkins password will work but we won't be able to see the password on our screen,we will still nedd to ssh into our ec2 in order to view the password. 
  #to avoid using ssh to go into our ec2 instance,let's use another method:
  tags = {
    Name = var.ec2-name[count.index]
  }
}
