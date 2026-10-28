resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.nch.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.env_prefix}-public-subnet-${var.availability_zones[count.index]}"
    Environment = var.env_prefix
    Tier        = "Public"
  }
}

# Private Application Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.nch.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.env_prefix}-private-subnet-${var.availability_zones[count.index]}"
    Environment = var.env_prefix
    Tier        = "Private"
  }
}

# Isolated Database Subnets
resource "aws_subnet" "database" {
  count             = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.nch.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.env_prefix}-db-subnet-${var.availability_zones[count.index]}"
    Environment = var.env_prefix
    Tier        = "Database"
  }
}

# --- 4. NAT GATEWAYS & ELASTIC IPS ---
resource "aws_eip" "nat" {
  count  = var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name        = "${var.env_prefix}-nat-eip-${count.index + 1}"
    Environment = var.env_prefix
  }
}

resource "aws_nat_gateway" "nat" {
  count         = var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.env_prefix}-nat-gw-${count.index + 1}"
    Environment = var.env_prefix
  }

  depends_on = [aws_internet_gateway.igw]
}

