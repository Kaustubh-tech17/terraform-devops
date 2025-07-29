# Terraform state is stored remotely in an S3 bucket.
# State locking is handled by a DynamoDB table.
terraform {
  backend "s3" {
    bucket         = "my-tf-state-s3-bucket-new" # <--- REPLACE with your unique S3 bucket name
    key            = "examples/aws-s3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-state-lock" # <--- REPLACE with your DynamoDB table name
    encrypt        = true
  }
} 
