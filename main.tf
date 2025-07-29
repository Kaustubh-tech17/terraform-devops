# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Call the reusable S3 bucket module
module "aws-s3-bucket" {
  source = "./modules/aws_s3_bucket"

  # Pass variables to the module
  bucket_name = var.bucket_name
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
} 
