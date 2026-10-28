terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }


}

provider "aws" {
  region     = "us-west-2"
  profile = "default"
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = "dev"
      Project     = "BMW"
    }
  }
}


