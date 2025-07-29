output "s3_bucket_id" {
  description = "The ID of the created S3 bucket."
  value       = module.my_s3_bucket.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the created S3 bucket."
  value       = module.my_s3_bucket.bucket_arn
} 
