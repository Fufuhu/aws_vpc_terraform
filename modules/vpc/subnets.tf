resource "aws_subnet" "public_subnets" {
  for_each   = toset(var.subnet_cidrs.public)
  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]

  tags = merge(
    var.subnet_additional_tags,
    {
      Name             = "${var.service_name}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]}-public-subnet"
      ServiceName      = var.service_name
      Env              = var.env
      Scope            = "public"
      AvailabilityZone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones]
    },
    local.default_resource_tags
  )
}


resource "aws_subnet" "private_subnets" {
  for_each   = toset(var.subnet_cidrs.private)
  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]

  tags = merge(
    var.subnet_additional_tags,
    {
      Name             = "${var.service_name}-${var.env}-${data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]}-private-subnet"
      Env              = var.env
      Scope            = "private"
      AvailabilityZone = data.aws_availability_zones.availability_zones.names[index(var.subnet_cidrs.private, each.key) % local.number_of_availability_zones]
    },
    local.default_resource_tags
  )
}