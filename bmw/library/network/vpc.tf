# --- 1. CORE VPC ---
resource "aws_vpc" "nch" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.env_prefix}-vpc"
    Environment = var.env_prefix
  }
}

# --- 2. INTERNET GATEWAY ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nch.id

  tags = {
    Name        = "${var.env_prefix}-igw"
    Environment = var.env_prefix
  }
}