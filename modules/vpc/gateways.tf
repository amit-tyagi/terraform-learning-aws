# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name          = "terraform-${var.infra_env}-igw"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    VPC           = aws_vpc.vpc.id
    ManagedBy     = "terraform"
  }

}

resource "aws_eip" "nat" {
  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name          = "terraform-${var.infra_env}-eip"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    VPC           = aws_vpc.vpc.id
    ManagedBy     = "terraform"
    Role          = "private"
  }

}

# NAT Gatweay (NGW)
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id

  tags = {
    Name          = "terraform-${var.infra_env}-ngw"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    VPC           = aws_vpc.vpc.id
    ManagedBy     = "terraform"
    Role          = "private"
  }

}

# Route Tables and Routes
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name          = "terraform-${var.infra_env}-public-rt"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    VPC           = aws_vpc.vpc.id
    ManagedBy     = "terraform"
    Role          = "public"
  }

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name          = "terraform-${var.infra_env}-private-rt"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    VPC           = aws_vpc.vpc.id
    ManagedBy     = "terraform"
    Role          = "private"
  }

}

# Public route
resource "aws_route" "public" {
  route_table_id          = aws_route_table.public.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.igw.id
}

# Private route
resource "aws_route" "private" {
  route_table_id          = aws_route_table.private.id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.ngw.id
}

# Public route to public Route Table for Public Subnets
resource "aws_route_table_association" "public" {
  for_each                = aws_subnet.public
  subnet_id               = aws_subnet.public[each.key].id
  route_table_id          = aws_route_table.public.id
}

# Private route to private Route Table for private Subnets
resource "aws_route_table_association" "private" {
  for_each                = aws_subnet.private
  subnet_id               = aws_subnet.private[each.key].id
  route_table_id          = aws_route_table.private.id
}
