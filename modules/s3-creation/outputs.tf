output "region" {
  value = "${var.region}"
}
output "bucket-name" {
  value = "${var.bucket-name}"
}
output "bucket-id" {
  value = "${aws_s3_bucket.my-bucket.id}"
}

output "terraform-state-lock" {
  value = "${var.terraform-state-lock}"
  
}
