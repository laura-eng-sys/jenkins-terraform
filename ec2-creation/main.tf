#configure aws provider

provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

#create vpc

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr= var.vpc_cidr
  vpc-tags= var.vpc-tags
  pub-sub1-cidr= var.pub-sub1-cidr
  pub-sub2-cidr= var.pub-sub2-cidr
  pub-sub1-tag= var.pub-sub1-tag
  pub-sub2-tag= var.pub-sub2-tag
  az= var.az


}

module "ec2" {
    source = "../modules/ec2"   
  ec2-ami = var.ec2-ami
  instance-type = var.instance-type
  key-name = var.key-name
  subnets = [module.vpc.pub-sub1-id, module.vpc.pub-sub2-id]
  security-group =  [module.vpc.security_group_id]
   
   
}

  



