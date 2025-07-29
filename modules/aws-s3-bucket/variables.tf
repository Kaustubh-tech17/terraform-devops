variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "versioning_status" {
  description = "The versioning state of the S3 bucket. Can be 'Enabled', 'Disabled', or 'Suspended'."
  type        = string
  default     = "Enabled"
} 
