resource "aws_vpc" "vpc" {
  cidr_block      = var.vpc_cidr

  tags = {
    Name          = "terraform-${var.infra_env}-vpc"
    Project       = "Terraform Project"
    Environment   = var.infra_env
    ManagedBy     = "terraform"
  }
}

resource "aws_subnet" "public" {
  for_each   = var.public_subnet_numbers
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name        = "terraform-${var.infra_env}-public-subnet"
    Project     = "Terraform Project"
    Role        = "public"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each        = var.private_subnet_numbers
  vpc_id          = aws_vpc.vpc.id
  cidr_block      = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name          = "terraform-${var.infra_env}-private-subnet"
    Project       = "Terraform Project"
    Role          = "private"
    Environment   = var.infra_env
    ManagedBy     = "terraform"
    Subnet        = "${each.key}-${each.value}"
  }

}