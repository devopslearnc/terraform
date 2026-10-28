module "bmw_test_vpc" {
  source = "../../library/network"

  env_prefix           = "test"
  vpc_cidr             = "10.100.0.0/16"
  availability_zones   = ["us-west-1a", "us-west-1b", "us-west-1c"]
  public_subnet_cidrs  = ["10.100.1.0/16", "10.100.2.0/16", "10.100.3.0/16"]
  private_subnet_cidrs = ["10.100.10.0/16", "10.100.20.0/16", "10.100.30.0/16"]
  database_subnet_cidrs= ["10.100.100.0/16", "10.100.110.0/16", "10.100.120.0/16"]
  single_nat_gateway   = false # Set to true for dev/staging to save cost, false for high-availability prod
}