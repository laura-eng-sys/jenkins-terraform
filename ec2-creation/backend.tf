terraform {
  backend "s3" {
    bucket    = "laurak-unique-bucket-name"
    dynamodb_table = "laurak-terraform-state-lock"
    key       = "demo/myproject/terraform.tfstate"
    region    = "us-east-1"
    encrypt = true
    profile   = "terraform-user"
    
  }
}
