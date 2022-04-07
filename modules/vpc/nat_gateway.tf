
# locals {
#   nat_gateway_availability_zones = var.nat_gateway_redundancy_enabled ? data.aws_availability_zones.availability_zones.names : [data.aws_availability_zones.availability_zones.names[0]]
# }

locals {
  from_az_to_public_subnet_id = { for cidr in keys(aws_subnet.public_subnets) : aws_subnet.public_subnets[cidr].tags["AvailabilityZone"] => aws_subnet.public_subnets[cidr].id }
}

resource "aws_eip" "eips" {
  for_each = local.from_az_to_public_subnet_id
  # for_each = toset(local.nat_gateway_availability_zones)
  vpc = true

  tags = {
    Name = "${var.service_name}-${var.env}-${each.key}-eip"
    AvailabilityZone = each.key
    Usage = "NAT"
  }
}


resource "aws_nat_gateway" "nat_gateways" {
  for_each = local.from_az_to_public_subnet_id
  allocation_id = aws_eip.eips[each.key].allocation_id
  subnet_id = each.value

  tags = {
    Name = "${var.service_name}-${var.env}-${each.key}-nat-gateway"
    AvailabilityZone = each.key
  }
}