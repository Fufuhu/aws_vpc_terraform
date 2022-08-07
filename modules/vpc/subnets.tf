resource "aws_subnet" "public_subnets" {
  for_each   = toset(var.subnet_cidrs.public)
  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]

  tags = merge(
    local.subnet_base_tags,
    {
      Name             = var.service_suffix == "" ? "${var.service_name}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]}-public-subnet" : "${var.service_name}-${var.service_suffix}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]}-public-subnet"
      Scope            = "public"
      AvailabilityZone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]
    },
  )
}


resource "aws_subnet" "private_subnets" {
  for_each   = toset(var.subnet_cidrs.private)
  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]

  tags = merge(
    local.subnet_base_tags,
    {
      Name             = var.service_suffix == "" ? "${var.service_name}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]}-private-subnet" : "${var.service_name}-${var.service_suffix}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]}-private-subnet"
      Scope            = "private"
      AvailabilityZone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]
    },
  )
}