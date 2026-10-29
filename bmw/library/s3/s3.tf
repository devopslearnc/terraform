resource "aws_s3_bucket" "bmw" {
  bucket = var.bucket_name
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
resource "aws_key_pair" "dev-jenkins" {
    key_name   = var.cert_name
    public_key = tls_private_key.ssh_key.public_key_openssh
    tags = {
    Name        = var.name
    Environment = var.environment
  }
}


resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = var.bits
  
}

resource "aws_s3_object" "cert_upload" {
  bucket  = var.bucket_name
  key     = "certs/id_rsa.pem"
  content = tls_private_key.ssh_key.private_key_pem

   tags = {
    Name        = var.name
    Environment = var.environment
  }
  depends_on = [
    aws_s3_bucket.bmw
  ]
}

