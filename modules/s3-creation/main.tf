#configure aws provider

provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

# Create a new S3 bucket

resource "aws_s3_bucket" "my-bucket" {
  bucket = var.bucket-name

}

#let's block public access to the bucket
resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket = aws_s3_bucket.my-bucket.id

  block_public_acls   = true
  block_public_policy = true
}

#create a dynamodb table to lock the state file. this resource avoid the corruption of the state file.
#when multiple users are working on the same terraform project, it is important to lock the state file to avoid corruption and only allow one user 
#to make changes at a time.\

resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "laurak-terraform-state-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

