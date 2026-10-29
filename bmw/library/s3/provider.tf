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


