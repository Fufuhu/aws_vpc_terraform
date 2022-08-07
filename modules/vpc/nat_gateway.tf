locals {
  # var.nat_gateway_redundancy_enabled がtrueだったらNAT Gatewayを3AZ分散、
  # falseだったらNAT Gatewayを単一AZに存在するよう修正
  from_az_to_public_subnet_id = var.nat_gateway_redundancy_enabled ? {
    for cidr in keys(aws_subnet.public_subnets) : aws_subnet.public_subnets[cidr].tags["AvailabilityZone"] => aws_subnet.public_subnets[cidr].id
  } : {
    "${aws_subnet.public_subnets[keys(aws_subnet.public_subnets)[0]].tags["AvailabilityZone"]}" = aws_subnet.public_subnets[keys(aws_subnet.public_subnets)[0]].id
  }
}

resource "aws_eip" "eips" {
  for_each = local.from_az_to_public_subnet_id
  vpc      = true

  tags = merge(
    {
      Name             = "${var.service_name}-${var.env}-${each.key}-eip"
      AvailabilityZone = each.key
      Usage            = "NAT"
    },
    local.default_resource_tags
  )
}


resource "aws_nat_gateway" "nat_gateways" {
  for_each      = local.from_az_to_public_subnet_id
  allocation_id = aws_eip.eips[each.key].allocation_id
  subnet_id     = each.value

  tags = merge(
    {
      Name             = "${var.service_name}-${var.env}-${each.key}-nat-gateway"
      AvailabilityZone = each.key
    },
    local.default_resource_tags
  )
}