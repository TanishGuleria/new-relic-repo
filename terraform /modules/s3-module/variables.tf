variable "region" {
  description = "The AWS region we want this bucket to live in."
  default     = "us-east-1"
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}
variable "allow_force_destroy" {
  description = "Allow us to destroy non-empty buckets (warning, bucket contents will be lost forever"
  default     = false
}

variable "lifecycle_rule_enabled" {
  description = "Enable lifecycle expiry on this bucket"
  default     = "false"
}

variable "expiration_days" {
  description = "Number of days after which to expunge the object"
  default     = 365
}

variable "encryption" {
  description = "The stype of encryption to force for objects"
  default     = "AES256"
}

