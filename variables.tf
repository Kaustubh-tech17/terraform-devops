variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "s3-example"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "The name for the S3 bucket to be created."
  type        = string
} 
