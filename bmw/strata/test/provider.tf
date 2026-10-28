terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a stable major version for production
    }
  }

  
}

provider "aws" {
  region = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # Default tags applied to every resource created by this provider (Production Best Practice)
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = "dev"
      Project     = "CoreInfrastructure"
    }
  }
}


variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
  default     = ""
}