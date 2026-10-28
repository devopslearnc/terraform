# --- 5. ROUTE TABLES & ASSOCIATIONS ---

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.nch.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.env_prefix}-public-rt"
    Environment = var.env_prefix
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Tables (One per AZ or shared depending on NAT setup)
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.nch.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[var.single_nat_gateway ? 0 : count.index].id
  }

  tags = {
    Name        = "${var.env_prefix}-private-rt-${var.availability_zones[count.index]}"
    Environment = var.env_prefix
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Database Route Table (Isolated - No internet gateway or NAT access)
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.nch.id

  tags = {
    Name        = "${var.env_prefix}-database-rt"
    Environment = var.env_prefix
  }
}

resource "aws_route_table_association" "database" {
  count          = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}

# --- 6. VPC FLOW LOGS (Production Compliance & Visibility) ---
resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aws/vpc-flow-log/${var.env_prefix}"
  retention_in_days = 30
}

resource "aws_iam_role" "flow_log" {
  name = "${var.env_prefix}-vpc-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}