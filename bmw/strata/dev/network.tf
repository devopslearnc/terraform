module "bmw_dev_vpc" {
  source = "../../library/network"

  env_prefix            = "dev"
  vpc_cidr              = "10.100.0.0/23"
  availability_zones    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidrs   = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
  private_subnet_cidrs  = ["10.100.10.0/24", "10.100.20.0/24", "10.100.30.0/24"]
  database_subnet_cidrs = ["10.100.100.0/24", "10.100.110.0/24", "10.100.120.0/24"]
  #single_nat_gateway   = false # Set to true for dev/staging to save cost, false for high-availability prod
}